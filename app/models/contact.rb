class Contact < ActiveRecord::Base
  validates_presence_of :fullname,:email,:address,:phone,:content
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :phone,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }
end
