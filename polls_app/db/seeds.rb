# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all



users = User.create([{username: 'Kevin Chou'},{username: 'Kevin La'}])

polls = Poll.create([{title: 'Bathroom etiquette', user_id: User.find_by("username = 'Kevin Chou'").id},{title: 'Cocktail preference', user_id: User.find_by("username = 'Kevin La'").id}])

questions = Question.create([{body: 'Crumpled or Folded?', poll_id: Poll.find_by(title: 'Bathroom etiquette').id}, {body: 'Stirred or Shaken?', poll_id: Poll.find_by(title: 'Cocktail preference').id}])

AnswerChoice.create([{body: 'Crumpled', question_id: Question.find_by(body: 'Crumpled or Folded?').id}, {body: 'Folded', question_id: Question.find_by(body: 'Crumpled or Folded?').id}])

# Response.create([{user_id: 8, answer_id: 1}])
# Response.create([{user_id: 2, answer_id: 2}])
