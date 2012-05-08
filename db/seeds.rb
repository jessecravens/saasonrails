# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
puts 'EMPTY THE MONGODB DATABASE'
Mongoid.master.collections.reject { |c| c.name =~ /^system/}.each(&:drop)
puts 'SETTING UP DEFAULT USER LOGIN'

Role.create name: 'admin'
Role.create name: 'owner'
Role.create name: 'manager'
Role.create name: 'employee'

=begin
user1 = User.create! email: 'user1@example.com', password: 'please', password_confirmation: 'please'
user1.create_profile first_name: 'Test', last_name: 'User1'
user1.add_role :admin
puts 'New user created: ' << user1.full_name

user2 = User.create! email: 'user2@example.com', password: 'please', password_confirmation: 'please'
user2.create_profile first_name: 'Test', last_name: 'User2'
user2.add_role :owner
puts 'New user created: ' << user2.full_name

user3 = User.create! email: 'user3@example.com', password: 'please', password_confirmation: 'please'
user3.create_profile first_name: 'Test', last_name: 'User3'
user3.add_role :manager
puts 'New user created: ' << user3.full_name
=end

puts 'POPULATING PLANS'

Stripe::Plan.all.data.each do |plan|
  Plan.create!(stripe_id: plan.id, amount: plan.amount, name: plan.name, interval: plan.interval)
end
