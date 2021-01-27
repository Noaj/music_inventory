require 'sqlite3'

begin
	puts "*** Creating db..."
    db = SQLite3::Database.new "music.db"
    puts "*** done!"
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    db.close if db
end