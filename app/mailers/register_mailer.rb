class RegisterMailer < ApplicationMailer
  default from: "ngockien16@gmail.com"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.register_mailer.register_email.subject
  #
  def register_email(user)
    @user = user
    mail to: user.email, subject: "Thank you for Register - your active code:"
  end
end
