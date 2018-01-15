# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Creando admin..."

admin = Admin.find_by(email: 'araluce11@gmail.com')

unless admin.nil?
  admin = Admin.new(email: 'araluce11@gmail.com', password: 'sintime')
  admin.save!
end
