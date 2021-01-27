require 'sqlite3'
require_relative "search"
require_relative "music"

#Module use for insert into DB
module Insert
  # Insert new artist
  def self.insert_new_artist(artist_id:, name:)
  	norm_name = Music.normalizer(name: name)
  	query = "INSERT INTO artists (id, name, normalized_name, created_at, updated_at) VALUES 
			('#{artist_id}', '#{name}', '#{norm_name}', datetime('now'), datetime('now'))"

	result = execute_query(query: query)
  end
  
  #Insert new album
  def self.insert_new_album(album_id:, title:, artist_id:, release_year:)
  	query =  "INSERT INTO albums (id, artist_id, title, release_year, created_at, updated_at) VALUES 
		('#{album_id}', '#{artist_id}', '#{title}', '#{release_year}', datetime('now'), datetime('now'))"

	result = execute_query(query: query)	
  end
  
  #Insert new item in inventory
  def self.insert_new_item(inventory_id:, album_id:, format:, quantity:)
  	query = "INSERT INTO inventory(id, album_id, format, quantity, created_at, updated_at) VALUES
		('#{inventory_id}', '#{album_id}', '#{format}', #{quantity}, datetime('now'), datetime('now'))"

  	result = execute_query(query: query)
  end
  
  # Execute query
  def self.execute_query(query:)
  	db = SQLite3::Database.open "music.db"
    result = db.execute query
    db.close if db

    if result.empty?
      nil
    else
      puts result
    end
  end
end
