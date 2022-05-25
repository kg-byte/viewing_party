# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Party.destroy_all

User.create(name: 'Admin', email: 'admin@email.com', password: 'admin', role: 1)
User.create(name: 'Jeff', email: 'jeff@email.com', password: 'jeff')
User.create(name: 'Amy', email: 'amy@email.com', password: 'amy')
