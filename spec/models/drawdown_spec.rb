require 'rails_helper'

RSpec.describe Drawdown, type: :model do
 #  	context "db" do
	# 	context "columns" do
	# 		it { should have_db_column(:id).of_type(:integer).with_options(null: false) }
	# 		it { should have_db_column(:sponsor_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:contract_date).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:media_contract_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:contract_time).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:position).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:media_appoint_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:appoint_in_contact).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:salary).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:media_salary_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:amount).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:amount_time).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:purpose).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:pay_time).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:account_holders).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:account_number).of_type(:string).with_options(null: true) }
	# 		it { should have_db_column(:bank_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:branch_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:user_id).of_type(:integer).with_options(null: true) }
	# 		it { should have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
	# 		it { should have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
	# 		it { should have_db_column(:is_draft).of_type(:integer).with_options(null: true) }
	# 	end
	# end


	context "attributes" do

	    it "has sponsor_id" do
	    	# email = Faker::Internet.email
	    	# puts email
	      	expect(build(:drawdown, sponsor_id: 12)).to have_attributes(sponsor_id: 12)
	    end

	    it "has contract_date" do
	    	contract_date = Date.today.strftime('%d-%m-%Y')
	      	expect(build(:drawdown, contract_date: contract_date)).to have_attributes(contract_date: contract_date)
	    end

	    it "has media_contract_id" do
	    	media_contract_id = 12
	      	expect(build(:drawdown, media_contract_id: media_contract_id)).to have_attributes(media_contract_id: media_contract_id)
	    end

	    it "has contract_time" do
	    	contract_time = Date.today.strftime('%d-%m-%Y')
	      	expect(build(:drawdown, contract_time: contract_time)).to have_attributes(contract_time: contract_time)
	    end

	    it "has position" do
	    	position = 1
	      	expect(build(:drawdown, position: position)).to have_attributes(position: position)
	    end

	    it "has media_appoint_id" do
	    	media_appoint_id = 12
	      	expect(build(:drawdown, media_appoint_id: media_appoint_id)).to have_attributes(media_appoint_id: media_appoint_id)
	    end

	    it "has appoint_in_contact" do
	    	appoint_in_contact = 1
	      	expect(build(:drawdown, appoint_in_contact: appoint_in_contact)).to have_attributes(appoint_in_contact: appoint_in_contact)
	    end

	    it "has salary" do
	    	salary = 1000000
	      	expect(build(:drawdown, salary: salary)).to have_attributes(salary: salary)
	    end

	    it "has media_salary_id" do
	    	media_salary_id = 13
	      	expect(build(:drawdown, media_salary_id: media_salary_id)).to have_attributes(media_salary_id: media_salary_id)
	    end

	    it "has amount" do
	    	amount = 15000000
	      	expect(build(:drawdown, amount: amount)).to have_attributes(amount: amount)
	    end

	    it "has amount_time" do
	    	amount_time = '2'
	      	expect(build(:drawdown, amount_time: amount_time)).to have_attributes(amount_time: amount_time)
	    end

	    it "has purpose" do
	    	purpose = 'Investment'
	      	expect(build(:drawdown, purpose: purpose)).to have_attributes(purpose: purpose)
	    end

	    it "has pay_time" do
	    	pay_time = '4'
	      	expect(build(:drawdown, pay_time: pay_time)).to have_attributes(pay_time: pay_time)
	    end

	    it "has account_holders" do
	    	account_holders = 'Nguyen Van A'
	      	expect(build(:drawdown, account_holders: account_holders)).to have_attributes(account_holders: account_holders)
	    end

	    it "has account_number" do
	    	account_number = '1546132165454'
	      	expect(build(:drawdown, account_number: account_number)).to have_attributes(account_number: account_number)
	    end

	    it "has bank_id" do
	    	bank_id = 13
	      	expect(build(:drawdown, bank_id: bank_id)).to have_attributes(bank_id: bank_id)
	    end

	    it "has branch_id" do
	    	branch_id = 12
	      	expect(build(:drawdown, branch_id: branch_id)).to have_attributes(branch_id: branch_id)
	    end

	    it "has user_id" do
	    	user_id = 1
	      	expect(build(:drawdown, user_id: user_id)).to have_attributes(user_id: user_id)
	    end

	    it "has is_draft" do
	    	is_draft = 1
	      	expect(build(:drawdown, is_draft: is_draft)).to have_attributes(is_draft: is_draft)
	    end
	end

	# context "validation" do
	# 	email = Faker::Internet.email
	# 	password = Faker::Internet.password
	# 	first_name = Faker::Name.first_name
	# 	last_name = Faker::Name.last_name
	# 	# puts email
	#     let(:user) { build(:drawdown, sponsor_id: sponsor_id,contract_date: contract_date,media_contract_id: media_contract_id,contract_time: contract_time,position: position,media_appoint_id: media_appoint_id,appoint_in_contact: appoint_in_contact,salary: salary,media_salary_id: media_salary_id,amount: amount,amount_time: amount_time,purpose: purpose,pay_time: pay_time,account_holders: account_holders,account_number: account_number,bank_id: bank_id,branch_id: branch_id,user_id: user_id,is_draft: is_draft) }



	#     it "requires unique email" do
	#       expect(user).to validate_uniqueness_of(:email)
	#     end

	#     it "requires email" do
	#       expect(user).to validate_presence_of(:email)
	#     end

	#     it "requires first_name" do
	#       expect(user).to validate_length_of(:first_name)
	#     end

	#     it "requires last_name" do
	#       expect(user).to validate_length_of(:last_name)
	#     end
	#   end

end
