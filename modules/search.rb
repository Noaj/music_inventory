require 'sqlite3'
require_relative "result_format"

# Module use for DB search
module Search

  # Search by artist name
  def self.search_by_name(artist_name:)
    query = "SELECT a.name as artist_name, al.title as album_name, al.release_year as release, i.format as inventory_format, i.quantity as inventory_qty, i.id, al.id
      FROM artists AS a 
      JOIN albums AS al ON a.id = al.artist_id
      JOIN inventory as i ON al.id = i.album_id
      WHERE i.quantity > 0 AND a.name LIKE '%#{artist_name}%'
      ORDER BY a.name ASC"

    result = execute_query(query: query)
    if result
      ResultFormat.result_format(data: result)
    end 
  end

  # Search by album title
  def self.search_by_title(albun_title:)
    query = "SELECT a.name as artist_name, al.title as album_name, al.release_year as release, i.format, i.quantity, i.id, al.id
      FROM artists AS a 
      JOIN albums AS al ON a.id = al.artist_id
      JOIN inventory as i ON al.id = i.album_id
      WHERE i.quantity > 0 AND al.title LIKE '%#{albun_title}%'
      ORDER BY al.title ASC"

    result = execute_query(query: query)
    if result
      ResultFormat.result_format(data: result)
    end  
  end
  
  # Search by release year
  def self.search_by_released(release_year:)
    query = "SELECT a.name as artist_name, al.title as album_name, al.release_year as release, i.format, i.quantity, i.id, al.id
      FROM artists AS a 
      JOIN albums AS al ON a.id = al.artist_id
      JOIN inventory as i ON al.id = i.album_id
      WHERE i.quantity > 0 AND al.release_year = '#{release_year}'
      ORDER BY al.created_at DESC"

    result = execute_query(query: query)
    if result
      ResultFormat.result_format(data: result)
    end
  end

  # Search by album format
  def self.search_by_format(format:)
    query = "SELECT a.name as artist_name, al.title as album_name, al.release_year as release, i.format, i.quantity, i.id, al.id
      FROM artists AS a 
      JOIN albums AS al ON a.id = al.artist_id
      JOIN inventory as i ON al.id = i.album_id
      WHERE i.quantity > 0 AND i.format = '#{format}'
      ORDER BY i.created_at DESC"

    result = execute_query(query: query)
    if result
      ResultFormat.result_format(data: result)
    end
  end

  # Checks if an album is in inventory
  def self.in_stock_by_inventory_id(inventory_id:)
  	query = "SELECT * FROM inventory where id = '#{inventory_id}' and quantity > 0;"
  	result = execute_query(query: query)
  end
  
  # Seach by artist id
  def self.by_artist_id(artist_id:)
    query = "SELECT * FROM artists where id = '#{artist_id}';"
    result = execute_query(query: query)
  end
  
  #  Search by album id
  def self.by_album_id(album_id:)
    query = "SELECT * FROM albums where id = '#{album_id}';"
    result = execute_query(query: query)
  end
  
  # search by inventory id
  def self.by_inventory_id(inventory_id:)
    query = "SELECT * FROM inventory where id = '#{inventory_id}';"
    result = execute_query(query: query)
  end

  # Search artist, album by inventory id
  def self.artist_album_by_inventory_id(inventory_id:)
    query = "SELECT a.name as artist_name, al.title as album_name, i.format as format 
      FROM inventory AS i 
      JOIN albums AS al ON i.album_id = al.id
      JOIN artists as a ON al.artist_id = a.id
      where i.id = '#{inventory_id}';"

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
      result
    end
  end	
end
