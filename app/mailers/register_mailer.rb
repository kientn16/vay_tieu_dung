class RegisterMailer < ApplicationMailer
  default from: "ngockien16@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.register_mailer.register_email.subject
  #
  def register_email(user)
    @user = user
    # @url  = get_active_code_path
    # @url  = user_url(@user, host: request.host_with_port )
    # binding.pry
    mail to: user.email, subject: "Thank you for Register - your active code:"
  end
end
