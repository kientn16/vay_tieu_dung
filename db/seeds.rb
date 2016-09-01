# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'
# seeds users
csv_user_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_users.csv'))
csv_user = CSV.parse(csv_user_text, :headers => true, :encoding => 'ISO-8859-1')
csv_user.each do |row|
  t = User.new
  t.email = row['email']
  t.password = row['password']
  t.status = row['status']
  t.save
end

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

# puts "There are now #{Content.count} rows in the transactions table Content"

# # seeds sponsor
# csv_sponsor_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_sponsors.csv'))
# csv_sponsor = CSV.parse(csv_sponsor_text, :headers => true, :encoding => 'iso-8859-1:utf-8')
# csv_sponsor.each do |row|
#   t = Sponsor.new
#   t.name = row['name']
#   t.save
# end

# puts "There are now #{Sponsor.count} rows in the transactions table Sponsor"

# # seeds admin
# csv_admin_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_admin.csv'))
# csv_admin = CSV.parse(csv_admin_text, :headers => true, :encoding => 'iso-8859-1:utf-8')
# csv_admin.each do |row|
#   t = Admin.new
#   t.username = row['username']
#   t.password = row['password']
#   t.status = row['status']
#   t.save
# end
# puts "There are now #{Admin.count} rows in the transactions table Admin"


# # seed province
# csv_prov_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_province_demo.csv'))
# csv_prov = CSV.parse(csv_prov_text, :headers => true, :encoding => 'iso-8859-1:utf-8')
# csv_prov.each do |row|
#   t = Province.new
#   t.name = row['name']
#   t.parent_id = row['parent_id']
#   t.save
# end

# puts "There are now #{Province.count} rows in the transactions table Province"

# # seed bank
# csv_bank_text = File.read(Rails.root.join('lib', 'seeds', 'seed_csv_bank.csv'))
# csv_bank = CSV.parse(csv_bank_text, :headers => true, :encoding => 'iso-8859-1:utf-8')
# csv_bank.each do |row|
#   t = Bank.new
#   t.name = row['name']
#   t.parent_id = row['parent_id']
#   t.save
# end

# puts "There are now #{Bank.count} rows in the transactions table Bank"