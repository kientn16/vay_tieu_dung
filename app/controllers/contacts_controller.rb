class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    respond_to do |format|
      if @contact.save
        # send mail
        ContactMailer.contact_email(@contact).deliver_now
        format.html { redirect_to new_contact_url, notice: 'Thank you for contacting us' }
        format.json { render :new, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:fullname,:email,:address,:phone,:content)
  end
end
