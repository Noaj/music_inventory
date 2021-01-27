require_relative "modules/search"
require_relative "modules/update"

class Purchase
  # Removed a item from inventory
  def self.deduct_item_from_inventory(inventory_id:)
  	in_stock = Search.in_stock_by_inventory_id(inventory_id: inventory_id)

  	if in_stock
  	  Update.decrease_inventory_quantity(inventory_id: inventory_id, quantity: 1)

      result = Search.artist_album_by_inventory_id(inventory_id: inventory_id)
      
  	  puts "Removed 1 #{result[0][2]} of #{result[0][1]} by #{result[0][0]} from the inventory"
  	else
  	  puts "Record not in stock"	
  	end	
  end
end

inventory_id =  ARGV[0]

Purchase.deduct_item_from_inventory(inventory_id: inventory_id)
