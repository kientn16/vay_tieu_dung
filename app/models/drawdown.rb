class Drawdown < ActiveRecord::Base
  belongs_to :bank, class_name: 'Bank', foreign_key: 'bank_id'
  belongs_to :branch, class_name: 'Bank', foreign_key: 'branch_id'
  belongs_to :user
  belongs_to :sponsor
  has_one :contract

  def self.get_contract_date(contract_date)
    case contract_date.to_i
      when 1
        result = "Từ 1 đến 3 năm"
      when 2
        result = "Từ 6 tháng đến 1 năm"
      when 3
        result = "Dưới 6 tháng"
      when 4
        result = "Trên 3 năm/Không xác định thời hạn"
      when 5
        result = "Làm việc tại DN người cùng tham gia trả nợ sở hữu."
    end
    return result
  end

  def self.get_appoint_in_contact(appoint_in_contact)
    case appoint_in_contact.to_i
      when 1
        return "Có"
      when 0
        return "Không"
    end
  end

  def self.get_position(position)
    case position.to_i
      when 1
        result = "Chuyên viên"
      when 2
        result = "Cán bộ quản lý"
      when 3
        result = "Cán bộ được đào tạo nghề"
      when 4
        result = "Lao động thời vụ"
    end
    return result
  end

  def self.get_amount_time(amount_time)

    case amount_time.to_i
      when 1
        result = "36 Tháng"
      when 2
        result = "24 Tháng"
      when 3
        result = "12 Tháng"
    end
    return result
  end


end
