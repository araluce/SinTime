# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creando ciudadano..."

ciudadano = User.find_by(email: 'araluce11@gmail.com')

unless ciudadano.nil?
  ciudadano = User.create_by(email: 'araluce11@gmail.com', password: 'sintime')
end
