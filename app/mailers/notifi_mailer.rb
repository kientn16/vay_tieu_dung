class NotifiMailer < ApplicationMailer
  default from: "no-reply@vaytieudung.com"

  def notifi_email(user,type)
    @user = user
    @type = type
    mail(to: @user.email, subject: 'Notifications vay tieu dung')
  end
end
