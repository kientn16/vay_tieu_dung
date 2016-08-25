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
    end
  end
end
