require_relative "../modules/music"
require "test/unit"

class TestMusicModule < Test::Unit::TestCase
  # When valid extension 
  def test_can_detect_file_format
    filenames_tests = [
        ['fulanito.csv', 'csv'],  # Simple file
        ['test.pipe.csv', 'csv'],
        ['test.csv.pipe', 'pipe'],
        ['c://test.csv.pipe', 'pipe'], # Windows path
        ['/var/log/test.csv.pipe', 'pipe'] # Unix path
    ]

    filenames_tests.each do |fn|
      assert_equal(Music.detect_format(file_name: fn[0]), fn[1])	 
    end
  end

  # When invalid extension
  def test_throw_exception_if_wrong_file_format
  	assert_raise(Exception) {Music.detect_format(file_name: 'fulanito.csv.something')}
  end	

  # Should make artist id
  def test_make_artist_id
  	artists_names = [
        ['   Papito', '   papiTo  '],
        ['Felito', 'FELITO'],
        ['ito', 'ITO']
    ]

    artists_names.each do |an|
      assert_equal(Music.make_artist_id(artist_name: an[0]), Music.make_artist_id(artist_name: an[1]))	
    end
  end

  # Should make album id
  def test_make_album_id
    test_hsh = {
      'artist1': '   Papito', 
      'album1': 'Hello  ',
      'artist2': '   PapiTo       ',
      'album2': '   HeLlO'
    }

    assert_equal(Music.make_album_id(artist_name: test_hsh[:artist1], album_title: test_hsh[:album1]), Music.make_album_id(artist_name: test_hsh[:artist2], album_title: test_hsh[:album2]))
  end

  # Should make inventory id
  def test_make_inventory_id
    test_hsh = {
      'format1': 'CD', 
      'album1': 'OG 4 life',
      'format2': 'cD',
      'album2': ' Og 4 lIfe'
    }
    #album_format:, album_title:
    assert_equal(Music.make_inventory_id(album_format: test_hsh[:format1], album_title: test_hsh[:album1]), Music.make_inventory_id(album_format: test_hsh[:format2], album_title: test_hsh[:album2]))
  end

  # Should normalize name
  def test_normalizer
    artists_names = [
      'Paramore', 'pAraMore'
    ]

    assert_equal(Music.normalizer(name: artists_names[0]), Music.normalizer(name: artists_names[1]))
  end

  # Should ormalize format
  def test_format_name_normalizer
    format_names = [
      'Vinyl', ' vInYl'
    ]

    assert_equal(Music.format_name_normalizer(fmt: format_names[0]), Music.format_name_normalizer(fmt: format_names[0]))
  end
end	
