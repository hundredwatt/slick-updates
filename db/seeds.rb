# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
UpdateForm.create(name: 'Jason\'s Form').tap do |form|
  form.questions.create(text: 'Favorite Moment?')
  form.questions.create(text: 'Obstacle?')
end
