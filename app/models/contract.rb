require 'csv'
class Contract < ActiveRecord::Base
  belongs_to :user
  # belongs_to :drawdown, class_name: 'Drawdown', foreign_key: 'drawdowns_id'

  def self.get_status(status)
    case status
      when 0
        return "Chấp nhận đề nghị vay."
      when 1
        return "Chờ xử lý.."
      when 2
        return "Không chấp nhận đề nghị vay."
      when 3
        return "Đã ký HĐ vay. Chờ giải ngân."
      when 4
        return "Đã giải ngân."
      when 5
        return "Đã tất toán."
      else
        return "Đề nghị vay nháp"
    end
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      # binding.pry
      all.each do |contract|
        csv << contract.attributes.values_at(*column_names)
      end
    end
  end
end
