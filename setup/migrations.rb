require 'sqlite3'

begin
	db = SQLite3::Database.open "music.db"
	puts "*** Creating tables..."

    db.execute "CREATE TABLE IF NOT EXISTS artists (
    		id string PRIMARY KEY,
    		name text NOT NULL,
    	    normalized_name text NOT NULL,
    	    created_at text NOT NULL,
            updated_at text NOT NULL
    	)"

	# Asumes inique names
	db.execute "CREATE UNIQUE INDEX idx_artists_name 
	ON artists (name);"

	db.execute "CREATE TABLE IF NOT EXISTS albums (
		id string PRIMARY KEY,
		artist_id string NOT NULL,
		title text NOT NULL,
	    release_year integer NOT NULL,
	    created_at text NOT NULL,
        updated_at text NOT NULL,
		FOREIGN KEY (artist_id) REFERENCES artist (id)
	)"

	db.execute "CREATE TABLE IF NOT EXISTS inventory (
	  	id string PRIMARY KEY,
	  	album_id string NOT NULL,
	    format text NOT NULL,
	    quantity integer NOT NULL,
	    created_at text NOT NULL,
        updated_at text NOT NULL,
	    FOREIGN KEY (album_id) REFERENCES album (id)
	)"  

    puts "*** done!"
rescue SQLite3::Exception => e 
    
    puts "Exception occurred"
    puts e
    
ensure
    db.close if db
end