# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
# seeds content
# csv_content_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_content.csv'))
# csv_content = CSV.parse(csv_content_text, :headers => true, :encoding => 'ISO-8859-1')
# csv_content.each do |row|
#   t = Content.new
#   t.title = row['title']
#   t.description = row['description']
#   t.content = row['content']
#   t.status = row['status']
#   t.type = row['type']
#   t.save
# end

# puts "There are now #{Content.count} rows in the transactions table"

# # seeds sponsor
# csv_sponsor_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_sponsors.csv'))
# csv_sponsor = CSV.parse(csv_sponsor_text, :headers => true, :encoding => 'iso-8859-1:utf-8')
# csv_sponsor.each do |row|
#   t = Sponsor.new
#   t.name = row['name']
#   t.save
# end

# puts "There are now #{Sponsor.count} rows in the transactions table"

# seeds admin
csv_admin_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_admin.csv'))
csv_admin = CSV.parse(csv_admin_text, :headers => true, :encoding => 'iso-8859-1:utf-8')
csv_admin.each do |row|
  t = Admin.new
  t.username = row['username']
  t.password = row['password']
  t.status = row['status']
  t.save
end

puts "There are now #{Admin.count} rows in the transactions table"