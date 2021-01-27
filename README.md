# Music Records Inc

Welcome to the future of music inventory system!

This will be the defacto standard for inventory system for music. The new amazing features and tools will be
driven by marketing and sales. For now, we will build the skeleton of the application so the
user can have a taste of the future!

#### Style Guides
These are the guides that we follow:

- [Ruby Style Guide](https://www.w3resource.com/ruby/ruby-style-guide.php)

#### Setup
Lets get started by cloning the project from github:
-   Go to https://github.com/Noaj/music_inventory
-   Click the "code" button and copy the ssh url. Should look like this: `git@github.com:Noaj/music_inventory.git`
-   If you dont have a directory for projects, create a directory in your local machine with `mkdir <new_dir>` 
-   Move to the new directory with `cd <new_dir>`
-   Clone music_inventory project: `git clone <copied url>`

Now that we have our project in place, lets run it!:
* From the console, go to the directory of the project and run thi command to create the db: `ruby setup/db_setup.rb` 
* For migratons run: `ruby setup/migrations.rb`
* [Optional] If you want mock data run: `ruby setup/seed.rb`

Notes: For this demo we are using a small db named `sqlite` for a more robust implementation we could use `Postgres`.

Now that we have our db setup, its time to try it!!

# How to use it

#### The app uses 3 different commands:
 - Load inventory: `ruby load_inventory.rb <PATH_TO_FILE>`
 - Search: `ruby search_inventory.rb "<field_option>" "<substring>"`
 - Purchase: `ruby purchase.rb "<inventory_id>"`
     
And there is much room for improvement!
