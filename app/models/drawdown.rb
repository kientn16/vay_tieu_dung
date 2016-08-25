class Drawdown < ActiveRecord::Base
	attr_accessor :is_validate
	validates_presence_of :sponsor_id, :contract_date, :media_contract_id, :contract_time, :position, :media_appoint_id, :salary, :media_salary_id, :amount, :amount_time, :purpose, :pay_time, :account_holders, :account_number, :bank_id, :branch_id, if: Proc.new{|u| u.is_validate }

	# def is_validate
	#     editting_context_interface == :interface
	#   end
	def get_day(format)
		if !self.contract_time.nil? || !self.contract_time.blank?
		DateTime.parse(self.contract_time).strftime(format)
		else
			nil
		end
	end
end
