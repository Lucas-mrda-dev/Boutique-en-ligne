# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

puts "🧹 Nettoyage de la base..."
Attendance.destroy_all
Event.destroy_all
User.destroy_all

puts "👤 Création des utilisateurs..."
users = []
5.times do |i|
  users << User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Quote.famous_last_words,
    email: Faker::Internet.unique.email,
    password: "password#{i + 1}",
    password_confirmation: "password#{i + 1}",
    created_at: Time.now,
    updated_at: Time.now
  )
end

puts "🎉 Création des événements..."
events = []
5.times do |i|
  admin = users.sample
  events << Event.create!(
    title: Faker::Lorem.sentence(word_count: 3),
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: rand(10..100),
    location: Faker::Address.city,
    start_date: Faker::Time.forward(days: rand(5..30), period: :evening),
    duration: [30, 60, 90, 120].sample,
    admin: admin
  )
end

puts "🎟️ Création des participations..."
10.times do
  Attendance.create!(
    user: users.sample,
    event: events.sample,
    stripe_customer_id: SecureRandom.hex(6)
  )
end

puts "✅ Base de données initialisée avec succès !"
puts "Utilisateurs : #{User.count}"
puts "Événements : #{Event.count}"
puts "Participations : #{Attendance.count}"

