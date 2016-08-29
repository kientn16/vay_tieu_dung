class Drawdown < ActiveRecord::Base
	attr_accessor :is_validate
	validates_presence_of :sponsor_id, :contract_date, :media_contract_id, :contract_time, :position, :media_appoint_id, :salary, :media_salary_id, :amount, :amount_time, :purpose, :pay_time, :account_holders, :account_number, :bank_id, :branch_id, if: Proc.new{|u| u.is_validate }
  validates_numericality_of :amount, :salary, if: Proc.new{|u| u.is_validate }
	belongs_to :bank, class_name: 'Bank', foreign_key: 'bank_id'
	belongs_to :branch, class_name: 'Bank', foreign_key: 'branch_id'
	belongs_to :user
	belongs_to :sponsor
	has_one :contract


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

  def self.proccess_drawdown(drawdown, drawdown_params, params, user_id)
    draft = params[:draft]
    flag = false
    if draft.to_i == 1.to_i
      if drawdown.nil?
        flag = self.save_drawdown(drawdown_params, params, false, user_id)
      else
        flag = self.update_drawdown(drawdown, drawdown_params, params, 1, false)
      end
    else
      if drawdown.nil?
        flag = self.save_drawdown(drawdown_params, params, true, user_id)
      else
        flag = self.update_drawdown(drawdown, drawdown_params, params, 0, true)
      end
    end
    return flag
  end

  def self.proccess_contract(drawdown, user_id, status)
    contract = Contract.where('drawdowns_id = ? AND user_id = ?', drawdown.id, user_id).first
    if contract.nil?
      contract = Contract.create(:code => 'HD-' + user_id.to_s + '-' + Time.now.strftime('%s').to_s, :value => drawdown.amount, :deadline => drawdown.amount_time, :status => status, :drawdowns_id => drawdown.id, :loans_time => drawdown.created_at, :user_id => user_id)
      return contract
    else
      if contract.status != 2 && contract.status != 4 && contract.status != 5
        if contract.update(:status => status)
          return contract
        end
      end
      return nil
    end
  end

  def self.create_history(contract, user_id)
    if !contract.nil?
      history = History.create(:contract_id => contract.id, :status_contract => contract.status, :summery => contract.value, :user_id => user_id)
    else
      nil
    end
  end

  def self.create_notification(user_id, title, content)
    notification = Notification.create(:user_id => user_id, :title => title, :content => content, :is_read => 0 )
  end



  def self.save_drawdown(drawdown_params, params, validate, user_id)
    params[:drawdown][:appoint_in_contract] = 0
    listMedia = []
    if params[:media_contract_id]
      media = Medium.create(path: params[:media_contract_id])
      params[:drawdown][:media_contract_id] = media.id
      drawdown_params[:media_contract_id] = media.id
      listMedia << media.id
    end

    if params[:media_appoint_id]
      media = Medium.create(path: params[:media_appoint_id])
      params[:drawdown][:media_appoint_id] = media.id
      drawdown_params[:media_appoint_id] = media.id
      listMedia << media.id
    end

    if params[:media_salary_id]
      media = Medium.create(path: params[:media_salary_id])
      params[:drawdown][:media_salary_id] = media.id
      drawdown_params[:media_salary_id] = media.id
      listMedia << media.id
    end
    drawdown = Drawdown.new(drawdown_params)
    drawdown.user_id = user_id
    drawdown.is_draft = params[:draft];
    # drawdown.contract_date = params[:contract_date]
    drawdown.is_validate = validate
    check = drawdown.valid?
    if check == false
      Medium.delete(listMedia)
      return false
    else
      if drawdown.save
        if params[:draft].to_i == 1.to_i
            contract = self.proccess_contract(drawdown, user_id, 99)
            history = self.create_history(contract, user_id)
            notification = self.create_notification(user_id, "Da luu tam de nghi vay", "Ban da luu tam de nghi vay")
        else
          contract = self.proccess_contract(drawdown, user_id, 1)
          history = self.create_history(contract, user_id)
          notification = self.create_notification(user_id, "Da gui de nghi vay", "Ban da gui de nghi vay, Dang cho xu ly")
        end
        return true
      else
        return false
      end
    end

  end

  def self.update_drawdown(drawdown, drawdown_params, params, is_draft, validate)
    drawdown.is_validate = validate
    listMedia = []
    if params[:media_contract_id]
      media = Medium.create(path: params[:media_contract_id])
      params[:drawdown][:media_contract_id] = media.id
      drawdown_params[:media_contract_id] = media.id
      listMedia << media.id
    end

    if params[:media_appoint_id]
      media = Medium.create(path: params[:media_appoint_id])
      params[:drawdown][:media_appoint_id] = media.id
      drawdown_params[:media_appoint_id] = media.id
      listMedia << media.id
    end

    if params[:media_salary_id]
      media = Medium.create(path: params[:media_salary_id])
      params[:drawdown][:media_salary_id] = media.id
      drawdown_params[:media_salary_id] = media.id
      listMedia << media.id
    end
    drawdown_params[:is_draft] = is_draft
    
    if drawdown.update(drawdown_params)
      if params[:draft].to_i == 1.to_i
        contract = self.proccess_contract(drawdown, drawdown.user_id, 99)
        history = self.create_history(contract, drawdown.user_id)
        notification = self.create_notification(drawdown.user_id, "Da luu tam de nghi vay", "Ban da luu tam de nghi vay")
      else
        contract = self.proccess_contract(drawdown, drawdown.user_id, 1)
        history = self.create_history(contract, drawdown.user_id)
        notification = self.create_notification(drawdown.user_id, "Da gui de nghi vay", "Ban da gui de nghi vay, Dang cho xu ly")
      end
      return true
    end
    return false
  end

  
end
