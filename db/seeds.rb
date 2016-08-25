# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
# seeds content
csv_content_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_content.csv'))
csv_content = CSV.parse(csv_content_text, :headers => true, :encoding => 'ISO-8859-1')
csv_content.each do |row|
  t = Content.new
  t.title = row['title']
  t.description = row['description']
  t.content = row['content']
  t.status = row['status']
  t.type = row['type']
  t.save
end

puts "There are now #{Content.count} rows in the transactions table"