# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# setting up the roles
[:admin, :character, :player].each do |role|
  Role.find_or_create_by(name: role)
end

# Creating initial Admin
u = User.create!(
  first_name:     "Ad",
  last_name:      "Min",
  character_name: "Admin",
  email:          "b.dubaut@gmail.com",
  password:       "FadRemu8",
)
