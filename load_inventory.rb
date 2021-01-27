require_relative "modules/music"
require_relative "modules/update"
require_relative "modules/search"
require_relative "modules/insert"
require 'csv'

class LoadInventory
  # load new data to the inventory
  def self.load_new_inventory(file: )
    file_name = Music.detect_format(file_name: file)

    case file_name
    when 'csv'
      parse_csv_file(csv: file)
    when 'pipe'
      parse_pipe_file(pipe: file)
    else
      "File extension not supported"
    end
  end

  private
  
  #update inventory table with pipe file with order: Quanitity | Format | Release year | Artist | Title
  def self.parse_pipe_file(pipe:)
    artist_cache = {}
    album_cache = {}
    inventory_cache = {}

    CSV.foreach(pipe, { :col_sep => '|' }) do |data|
      quantity = data[0].to_i
      fmt = Music.format_name_normalizer(fmt: data[1])
      release_year = data[2]
      artist =  data[3].to_s.strip
      title = data[4].to_s.strip

      puts "artist: #{artist} - title: #{title} - fmt: #{fmt} - release_year: #{release_year} - q: #{quantity}"

      inventory_id = Music.make_inventory_id(album_format: fmt, album_title: title)
      artist_id = Music.make_artist_id(artist_name: artist) 
      album_id = Music.make_album_id(artist_name: artist, album_title: title)

      if artist_cache.key?(artist_id)
        puts "Artist #{artist} already existed"
      else
        result = Search.by_artist_id(artist_id: artist_id)
        if result.nil?
          Insert.insert_new_artist(artist_id: artist_id, name: artist)
          puts "New Artist added: #{artist}"
        end  
        artist_cache[artist_id] = artist
      end
        
      if album_cache.key?(album_id)
        puts "Album #{title} already existed"
      else
        result = Search.by_album_id(album_id: album_id)
        if result.nil?
          Insert.insert_new_album(album_id: album_id, title: title, artist_id: artist_id, release_year: release_year)
          puts "New Album added: #{title}"
        end
        album_cache[album_id] = title
      end  

      if inventory_cache.key?(inventory_id)
        puts "Already in inventory: #{inventory_id}"
      else
        result = Search.by_inventory_id(inventory_id: inventory_id)
        if result.nil?
          r = Insert.insert_new_item(inventory_id: inventory_id, album_id: album_id, format: fmt, quantity: quantity)
          puts "New item added to Inventory: #{inventory_id} - #{quantity}"
        else
          r = Update.increase_inventory_quantity(inventory_id: inventory_id, quantity: quantity)
          puts "Quantity updated for inventory_id: #{inventory_id} to #{quantity}"
        end
        inventory_cache[inventory_id] = inventory_id
      end
    end  
  end

  #update inventory table with csv file with order: Artist,Title,Format,Release year
  def self.parse_csv_file(csv:)
    artist_cache = {}
    album_cache = {}
    inventory_cache = {}
    csv_parse = CSV.parse(File.read(csv))

    csv_parse.each do |data|
      artist = data[0].to_s.strip
      title = data[1].to_s.strip
      fmt = Music.format_name_normalizer(fmt: data[2])
      release_year = data[3]

      inventory_id = Music.make_inventory_id(album_format: fmt, album_title: title)
      artist_id = Music.make_artist_id(artist_name: artist) 
      album_id = Music.make_album_id(artist_name: artist, album_title: title)

      if artist_cache.key?(artist_id)
        puts "Artist #{artist} already existed"
      else
        result = Search.by_artist_id(artist_id: artist_id)
        if result.nil?
          Insert.insert_new_artist(artist_id: artist_id, name: artist)
          puts "New Artist added"
        end  
        artist_cache[artist_id] = artist
      end
        
      if album_cache.key?(album_id)
        puts "Album #{title} already existed"
      else
        result = Search.by_album_id(album_id: album_id)
        if result.nil?
          Insert.insert_new_album(album_id: album_id, title: title, artist_id: artist_id, release_year: release_year)
          puts "New Album added"
        end
        album_cache[album_id] = title
      end  

      if inventory_cache.key?(inventory_id)
        puts "Already in inventory: #{inventory_id}"
      else
        result = Search.by_inventory_id(inventory_id: inventory_id)
        if result.nil?
          Insert.insert_new_item(inventory_id: inventory_id, album_id: album_id, format: fmt, quantity: 0)
          puts "New item added to Inventort: #{inventory_id}"
        end
        inventory_cache[inventory_id] = inventory_id
      end
    end  
  end 
end

file_name =  ARGV[0]

LoadInventory.load_new_inventory(file: file_name)
