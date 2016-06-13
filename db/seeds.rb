require 'pg'
require 'faker'

if ENV["RACK_ENV"] == "production"
  conn = PG.connect(
      dbname: ENV["POSTGRES_DB"],
      host: ENV["POSTGRES_HOST"],
      password: ENV["POSTGRES_PASS"],
      user: ENV["POSTGRES_USER"]
  )
else
  conn = PG.connect(dbname: "portfolio")
end

conn.exec("DROP TABLE IF EXISTS users")
conn.exec("DROP TABLE IF EXISTS reviews, comments, tags, meals, restaurants CASCADE")
conn.exec("CREATE TABLE users (id SERIAL PRIMARY KEY,
                                  first_name VARCHAR(150),
                                  last_name VARCHAR(150),
                                  username VARCHAR(150),
                                  password_digest VARCHAR(150),
                                  email VARCHAR(150),
                                  admin BOOLEAN,
                                  reset_digest VARCHAR(150),
                                  reset_sent_at TIMESTAMP WITH TIME ZONE,
                                  activation_digest VARCHAR(150),
                                  activated BOOLEAN,
                                  activated_at TIMESTAMP WITH TIME ZONE,
                                  remember_digest VARCHAR(150),
                                  about_me TEXT)")

conn.exec("CREATE TABLE restaurants (id SERIAL PRIMARY KEY,
                                      name VARCHAR(50),
                                      raw_address VARCHAR(150),
                                      google_map_url VARCHAR(150),
                                      lat FLOAT,
                                      lng FLOAT)")


conn.exec("COPY restaurants (Name,Raw_Address,Google_Map_URL,Lat,Lng) FROM '/Users/Allison/Dropbox (Personal)/General Assembly/final_project/mealpass-reviews/mp-restaurant-seed.csv' DELIMITER ',' CSV")

conn.exec("CREATE TABLE meals (id SERIAL PRIMARY KEY,
                                      name VARCHAR(50),
                                      description VARCHAR(300),
                                      vote_count INTEGER,
                                      restaurant_id INTEGER)")


conn.exec("COPY meals (Name,Description,Vote_Count,Restaurant_ID) FROM '/Users/Allison/Dropbox (Personal)/General Assembly/final_project/mealpass-reviews/meals-seed.csv' DELIMITER ',' CSV")

conn.exec("CREATE TABLE reviews (id SERIAL PRIMARY KEY,
                                      title VARCHAR(50),
                                      content VARCHAR,
                                      user_id INTEGER,
                                      meal_id INTEGER)")

conn.exec("CREATE TABLE comments (id SERIAL PRIMARY KEY,
                                      content VARCHAR,
                                      user_id INTEGER,
                                      review_id INTEGER)")

User.create!(first_name: "Alli",
             last_name: "Cummings",
             username: "alliesauce",
             email: "alli.cummings@gmail.com",
             password: "password",
             password_confirmation: "password",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  username = Faker::Internet.user_name
  email = "example-#{n+1}@mail.com"
  password = "password"
  User.create!(first_name: first_name,
               last_name: last_name,
               username: username,
               email: email,
               password: password,
               password_confirmation: password,
               admin: false,
               activated: true,
               activated_at: Time.zone.now)
end

