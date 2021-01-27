require 'json'
require_relative "modules/search"

class SearchInventory
  NOT_SEARCHABLE_ERROR_CODE = 800

  # search items by field name and a sub-string
  def self.search_record(field:, sub_string:)
    search_str = sub_string.downcase
    search_field = validate_searchable_field(field: field, search_str: search_str)

    if search_field.nil?
      puts "Not found"
    elsif search_field == NOT_SEARCHABLE_ERROR_CODE
      puts "#{field} not searchable on Music Record Inc"
    else  
      search_field
    end 
  end 

  private

  def self.validate_searchable_field(field:, search_str:)
    case field
    when 'artist'
      Search.search_by_name(artist_name: search_str)
    when 'album'
      Search.search_by_title(albun_title: search_str)
    when 'released'
      Search.search_by_released(release_year: search_str)
    when 'format'
      Search.search_by_format(format: search_str)
    else
      800
    end 
  end  
end

field =  ARGV[0]
string = ARGV[1]

result = SearchInventory.search_record(field: field, sub_string: string)
