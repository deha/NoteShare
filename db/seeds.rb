# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

first_user = User.create({:last_name => "Tytanowy", :first_name => "Jan"})
User.create({:last_name => "Molibdenowy", :first_name => "Mateusz"})

Note.create({:author => first_user, :title => "Simple title"})
