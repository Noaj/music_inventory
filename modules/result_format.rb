require 'json'

# Module use for response format
module ResultFormat

  # response with:
    # {
    #   Artist: data.artist
    #   Album: data.album
    #   Released: data.release_year
    #   CD:(<cd quantity>): data.cd_inventory_identifier
    #   Tape:(<tape quantity>): data.tape_inventory_identifier
    #   Viny:l(<vinyl quantity>): data.vinyl_inventory_identifier
    # }
  def self.result_format(data:)
    result = {}

    result_cache = {}
    #a.name as artist_name, al.title as album_name, al.release_year as release, i.format as inventory_format, i.quantity as inventory_qty, i.id, al.id
    data.each do |row|
      if result_cache.key?(row[6])
        result[row[6]].merge!(row[3]=> "(#{row[4]}): #{row[5]}")
      else
        result[row[6]] = {"Artist"=> row[0], "Album"=> row[1], "Released"=> row[2], "#{row[3]}(#{row[4]})"=> "#{row[5]}" }
        result_cache[row[6]] = row[6]
      end
    end
    print_format(result: result.values)  
  end

  def self.print_format(result:)
    h = []
    result.map do |r|
      r.map do |k, v|
        puts "#{k}: #{v}"
        h << "#{k}: #{v}"
      end
      puts "\n"
      h << "\n"
    end
    h
  end
end	
