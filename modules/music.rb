require 'digest/sha1'

#Module use for Music data for inventory
module Music
  # checks the format of the input file
  def self.detect_format(file_name:)
  	ext = File.extname(file_name)

    if '.csv' == ext
        'csv'
    elsif '.pipe' == ext
        'pipe'
    else
        raise Exception.new("File format not supported")
    end    
  end 

  # We create a id for our artist
  def self.make_artist_id(artist_name:)
  	norm_name = normalizer(name: artist_name)

    #We assume that naming is consistent on its format, but not on casing 
    hash_string(str_to_hash: norm_name)
  end

  # We create a id for our album
  def self.make_album_id(artist_name:, album_title:)
  	norm_name = normalizer(name: artist_name)
  	norm_title = normalizer(name: album_title)
  	
    # We assume that naming is consistent on its format, but not on casing
    strng = "#{norm_name.strip}#{norm_title.strip}"
    hash_string(str_to_hash: strng)
  end

  # We create a id for our inventory item
  def self.make_inventory_id(album_format:, album_title:)
    norm_format = format_name_normalizer(fmt: album_format)
    norm_title = normalizer(name: album_title)
    
    # We assume that naming is consistent on its format, but not on casing
    strng = "#{norm_format.strip}#{norm_title.strip}"
    hash_string(str_to_hash: strng)
  end

  def self.hash_string(str_to_hash:)
    clean_str = str_to_hash.downcase.strip.encode("utf-8")
    hsh = Digest::SHA1.hexdigest(clean_str)[0..30]
  end

  # String Normalizer
  def self.normalizer(name:)
  	normalize_name = name.strip.gsub(/\w+/, &:capitalize)
  end

  # Normalize format name
  def self.format_name_normalizer(fmt:)
    normalize_fmt = fmt.strip.downcase
  end
end
