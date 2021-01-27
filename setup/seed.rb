require 'sqlite3'
require_relative "../modules/music"

begin
	db = SQLite3::Database.open "music.db"
	artist_name1 = Music.normalizer(name: 'The killers')
	artist_name2 = Music.normalizer(name: 'GorillAz')
	artist_name3 = Music.normalizer(name: 'Bab Bunny')
	artist_name4 = Music.normalizer(name: 'classixx')

	format1 = Music.format_name_normalizer(fmt: 'CD')
	format2 = Music.format_name_normalizer(fmt: 'vinyL')
	format3 = Music.format_name_normalizer(fmt: 'tape')
	format4 = Music.format_name_normalizer(fmt: 'dVd')

	album_name1 = 'Hot Fuzz'
	album_name2 = 'Sams Town'
	album_name3 = 'Gorillaz'
	album_name4 = 'IDK'
	album_name5 = 'Holding on'

	puts "*** Seeding db..."


	db.execute "INSERT INTO artists (id, name, normalized_name, created_at, updated_at) VALUES 
		('#{Music.make_artist_id(artist_name: artist_name1)}', 'The killers', '#{artist_name1}', datetime('now'), datetime('now')),
		('#{Music.make_artist_id(artist_name: artist_name2)}', 'GorillAz', '#{artist_name2}', datetime('now'), datetime('now')),
		('#{Music.make_artist_id(artist_name: artist_name3)}', 'Bab BUnny', '#{artist_name3}', datetime('now'), datetime('now')),
		('#{Music.make_artist_id(artist_name: artist_name4)}', 'classixx', '#{artist_name4}', datetime('now'), datetime('now'))"
	puts "*** seeded artists..."

	db.execute "INSERT INTO albums (id, artist_id, title, release_year, created_at, updated_at) VALUES 
		('#{Music.make_album_id(artist_name: artist_name1, album_title: album_name1)}', '#{Music.make_artist_id(artist_name: artist_name1)}', 'Hot Fuzz', 2004, datetime('now'), datetime('now')),
		('#{Music.make_album_id(artist_name: artist_name1, album_title: album_name2)}', '#{Music.make_artist_id(artist_name: artist_name1)}', 'Sams Town', 2007, datetime('now'), datetime('now')),
		('#{Music.make_album_id(artist_name: artist_name2, album_title: album_name3)}', '#{Music.make_artist_id(artist_name: artist_name2)}', 'Gorillaz', 2001, datetime('now'), datetime('now')),
		('#{Music.make_album_id(artist_name: artist_name3, album_title: album_name4)}', '#{Music.make_artist_id(artist_name: artist_name3)}', 'IDK', 2017, datetime('now'), datetime('now')),
		('#{Music.make_album_id(artist_name: artist_name4, album_title: album_name5)}', '#{Music.make_artist_id(artist_name: artist_name4)}', 'Holding on', 2013, datetime('now'), datetime('now'))"
    puts "*** seeded albums..."

	db.execute "INSERT INTO inventory(id, album_id, format, quantity, created_at, updated_at) VALUES
		('#{Music.make_inventory_id(album_format: format1, album_title: album_name1)}', '#{Music.make_album_id(artist_name: artist_name1, album_title: album_name1)}', '#{format1}', 10, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format2, album_title: album_name1)}', '#{Music.make_album_id(artist_name: artist_name1, album_title: album_name1)}', '#{format2}', 8, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format3, album_title: album_name1)}', '#{Music.make_album_id(artist_name: artist_name1, album_title: album_name1)}', '#{format3}', 1, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format3, album_title: album_name2)}', '#{Music.make_album_id(artist_name: artist_name1, album_title: album_name2)}', '#{format3}', 11, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format4, album_title: album_name2)}', '#{Music.make_album_id(artist_name: artist_name1, album_title: album_name2)}', '#{format4}', 0, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format2, album_title: album_name3)}', '#{Music.make_album_id(artist_name: artist_name2, album_title: album_name3)}', '#{format2}', 13, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format1, album_title: album_name4)}', '#{Music.make_album_id(artist_name: artist_name3, album_title: album_name4)}', '#{format1}', 0, datetime('now'), datetime('now')),
		('#{Music.make_inventory_id(album_format: format3, album_title: album_name5)}', '#{Music.make_album_id(artist_name: artist_name4, album_title: album_name5)}', '#{format3}', 1, datetime('now'), datetime('now'))"
	puts "*** seeded inventory..."	

    puts "*** done!"
rescue SQLite3::Exception => e 
    #add rollback
    puts "Exception occurred"
    puts e
    
ensure
    db.close if db
end