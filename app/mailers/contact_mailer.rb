class ContactMailer < ApplicationMailer
  default from: "no-reply@vaytieudung.com"

  def contact_email(contact)
    @contact = contact
    mail(to: @contact.email, subject: 'Thank you for contacting us')
  end
end
