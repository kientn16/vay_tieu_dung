class Admin < ActiveRecord::Base
  validates_presence_of :username
  validates_presence_of :password, :on => :create
  before_save :hash_field

  def hash_field
    # binding.pry
    if self.password == "" || self.password == nil
      self.password = Admin.find(self.id).password
    else
      self.password = Digest::MD5.hexdigest(self.password)
    end

  end

  def self.authenticate(username,password)
    @check = self.where(["username = ? AND password = ?", username, md5(password)]).first
    # binding.pry
    if @check
      return @check
    else
      return false
    end
  end

  def self.md5(pass)
    Digest::MD5.hexdigest("#{pass}")
  end
end
