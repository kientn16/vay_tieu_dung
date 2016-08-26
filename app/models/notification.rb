class Notification < ActiveRecord::Base
  self.inheritance_column = nil
  belongs_to :user

  def self.get_all(params)
  	Notification.all.paginate(:page => params[:page], :per_page => Rails.application.config.pagination_per_page)
  end

  def self.get_notifications (is_read, user_id)
    if is_read == 'all'
      notifications = Notification.where('user_id = ?', user_id)
    else
      notifications = Notification.where('user_id = ? AND is_read = ?', user_id, is_read)
    end
  end


end
