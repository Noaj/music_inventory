require 'sqlite3'
require_relative "search"

# Module use for db updates
module Update

  # Decrease the quantity in inventory
  def self.decrease_inventory_quantity(inventory_id:, quantity:)
  	in_stock = Search.in_stock_by_inventory_id(inventory_id: inventory_id)

  	if in_stock
  	  query = "UPDATE inventory
			SET quantity = quantity - #{quantity}, updated_at = datetime('now')
			WHERE id = '#{inventory_id}'"

	  result = execute_query(query: query)
  	end	
  end
  
  # Increase the quantity in inventory
  def self.increase_inventory_quantity(inventory_id:, quantity:)
    query = "UPDATE inventory
      SET quantity = quantity + #{quantity}, updated_at = datetime('now')
      WHERE id = '#{inventory_id}'"

      result = execute_query(query: query)
  end
  
  # Execute query
  def self.execute_query(query:)
  	db = SQLite3::Database.open "music.db"
    result = db.execute query
    db.close if db

    result
  end
end
