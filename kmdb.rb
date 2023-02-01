# In this assignment, you'll be using the domain model from hw1 (found in the hw1-solution.sql file)
# to create the database structure for "KMDB" (the Kellogg Movie Database).
# The end product will be a report that prints the movies and the top-billed
# cast for each movie in the database.

# To run this file, run the following command at your terminal prompt:
# `rails runner kmdb.rb`

# Requirements/assumptions
#
# - There will only be three movies in the database – the three films
#   that make up Christopher Nolan's Batman trilogy.
# - Movie data includes the movie title, year released, MPAA rating,
#   and studio.
# - There are many studios, and each studio produces many movies, but
#   a movie belongs to a single studio.
# - An actor can be in multiple movies.
# - Everything you need to do in this assignment is marked with TODO!

# Rubric
# 
# There are three deliverables for this assignment, all delivered within
# this repository and submitted via GitHub and Canvas:
# - Generate the models and migration files to match the domain model from hw1.
#   Table and columns should match the domain model. Execute the migration
#   files to create the tables in the database. (5 points)
# - Insert the "Batman" sample data using ruby code. Do not use hard-coded ids.
#   Delete any existing data beforehand so that each run of this script does not
#   create duplicate data. (5 points)
# - Query the data and loop through the results to display output similar to the
#   sample "report" below. (10 points)

# Submission
# 
# - "Use this template" to create a brand-new "hw2" repository in your
#   personal GitHub account, e.g. https://github.com/<USERNAME>/hw2
# - Do the assignment, committing and syncing often
# - When done, commit and sync a final time before submitting the GitHub
#   URL for the finished "hw2" repository as the "Website URL" for the 
#   Homework 2 assignment in Canvas

# Successful sample output is as shown:

# Movies
# ======

# Batman Begins          2005           PG-13  Warner Bros.
# The Dark Knight        2008           PG-13  Warner Bros.
# The Dark Knight Rises  2012           PG-13  Warner Bros.

# Top Cast
# ========

# Batman Begins          Christian Bale        Bruce Wayne
# Batman Begins          Michael Caine         Alfred
# Batman Begins          Liam Neeson           Ra's Al Ghul
# Batman Begins          Katie Holmes          Rachel Dawes
# Batman Begins          Gary Oldman           Commissioner Gordon
# The Dark Knight        Christian Bale        Bruce Wayne
# The Dark Knight        Heath Ledger          Joker
# The Dark Knight        Aaron Eckhart         Harvey Dent
# The Dark Knight        Michael Caine         Alfred
# The Dark Knight        Maggie Gyllenhaal     Rachel Dawes
# The Dark Knight Rises  Christian Bale        Bruce Wayne
# The Dark Knight Rises  Gary Oldman           Commissioner Gordon
# The Dark Knight Rises  Tom Hardy             Bane
# The Dark Knight Rises  Joseph Gordon-Levitt  John Blake
# The Dark Knight Rises  Anne Hathaway         Selina Kyle

# Delete existing data, so you'll start fresh each time this script is run.
# Use `Model.destroy_all` code.
# TODO!
Studio.destroy_all
Movie.destroy_all
Actor.destroy_all
Role.destroy_all

# Generate models and tables, according to the domain model.
# TODO!
puts "The schema of the generated models/tables is:"
puts "====================================================="
puts "#{Studio.inspect}"
puts "#{Movie.inspect}"
puts "#{Actor.inspect}"
puts "#{Role.inspect}"

# Insert data into the database that reflects the sample data shown above.
# Do not use hard-coded foreign key IDs.
# TODO!

studio = Studio.new
studio.name = "Warner Bros."
studio.save

wb = Studio.find_by({"name"=>"Warner Bros."})

# Quick check.
puts "Studio count: #{Studio.all.count}"

movie = Movie.new
movie.title = "Batman Begins"
movie.year_released = 2005
movie.rated = "PG-13"
movie.studio_id = wb["id"]
movie.save

movie = Movie.new
movie.title = "The Dark Knight"
movie.year_released = 2005
movie.rated = "PG-13"
movie.studio_id = wb["id"]
movie.save

movie = Movie.new
movie.title = "The Dark Knight Rises"
movie.year_released = 2005
movie.rated = "PG-13"
movie.studio_id = wb["id"]
movie.save

b1 = Movie.find_by({"title" => "Batman Begins"})
b2 = Movie.find_by({"title" => "The Dark Knight"})
b3 = Movie.find_by({"title" => "The Dark Knight Rises"})

# Quick check.
puts "Movie count: #{Movie.all.count}"

Actor.insert_all(
    [
        {"name" => "Christian Bale"},
        {"name" => "Michael Caine"},
        {"name" => "Liam Neeson"},
        {"name" => "Katie Holmes"},
        {"name" => "Gary Oldman"},
        {"name" => "Heath Ledger"},
        {"name" => "Aaron Eckhart"},
        {"name" => "Maggie Gyllenhaal"},
        {"name" => "Tom Hardy"},
        {"name" => "Joseph Gordon-Levitt"},
        {"name" => "Anne Hathaway"}
    ]
)

cbale = Actor.find_by("name" => "Christian Bale")
mcaine = Actor.find_by("name" => "Michael Caine")
lneeson = Actor.find_by("name" => "Liam Neeson")
kholmes = Actor.find_by("name" => "Katie Holmes")
goldman = Actor.find_by("name" => "Gary Oldman")
hledger = Actor.find_by("name" => "Heath Ledger")
aeckhart = Actor.find_by("name" => "Aaron Eckhart")
mg = Actor.find_by("name" => "Maggie Gyllenhaal")
thardy = Actor.find_by("name" => "Tom Hardy")
jgl = Actor.find_by("name" => "Joseph Gordon-Levitt")
ahathaway = Actor.find_by("name" => "Anne Hathaway")

# Quick check.
puts "Actor count: #{Actor.all.count}"


Role.insert_all(
    [
        {"movie_id" => b1["id"], "actor_id" => cbale["id"], "character_name" => "Bruce Wayne"}, 
        {"movie_id" => b1["id"], "actor_id" => mcaine["id"], "character_name" => "Alfred"}, 
        {"movie_id" => b1["id"], "actor_id" => lneeson["id"], "character_name" => "Ra's Al Ghul"}, 
        {"movie_id" => b1["id"], "actor_id" => kholmes["id"], "character_name" => "Rachel Dawes"}, 
        {"movie_id" => b1["id"], "actor_id" => goldman["id"], "character_name" => "Commissioner Gordon"},

        {"movie_id" => b2["id"], "actor_id" => cbale["id"], "character_name" => "Bruce Wayne"},
        {"movie_id" => b2["id"], "actor_id" => hledger["id"], "character_name" => "Joker"},
        {"movie_id" => b2["id"], "actor_id" => aeckhart["id"], "character_name" => "Harvey Dent"},
        {"movie_id" => b2["id"], "actor_id" => mcaine["id"], "character_name" => "Alfred"},
        {"movie_id" => b2["id"], "actor_id" => mg["id"], "character_name" => "Rachel Dawes"},

        {"movie_id" => b3["id"], "actor_id" => cbale["id"], "character_name" => "Bruce Wayne"},  
        {"movie_id" => b3["id"], "actor_id" => goldman["id"], "character_name" => "Commissioner Gordon"},  
        {"movie_id" => b3["id"], "actor_id" => thardy["id"], "character_name" => "Bane"}, 
        {"movie_id" => b3["id"], "actor_id" => jgl["id"], "character_name" => "John Blake"},  
        {"movie_id" => b3["id"], "actor_id" => ahathaway["id"], "character_name" => "Selina Kyle"} 
    ]
)

# Quick check.
puts "Role count: #{Role.all.count}"



# Prints a header for the movies output
puts "\n\n\n"
puts "Movies"
puts "======"
puts ""

# Query the movies data and loop through the results to display the movies output.
# TODO!

# Prints a header for the cast output
puts ""
puts "Top Cast"
puts "========"
puts ""

# Query the cast data and loop through the results to display the cast output for each movie.
# TODO!
