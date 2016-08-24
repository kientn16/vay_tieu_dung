class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :email,:passport,:address,:district_id,:provined_id,:ward_id,:phone
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  # validates_length_of :phone, :minimum => 10, :allow_blank => false, :on => :update
  validates :phone,:presence => true,
            :numericality => true,
            :length => { :minimum => 10, :maximum => 15 }
  validates_length_of :name, :minimum => 3, :allow_blank => false, :on => :update
  validates_length_of :address, :minimum => 10, :allow_blank => false, :on => :update

  before_update :hash_field

  def self.check_active_code(params)
    @check = User.where("email = '#{params[:email]}' AND active_code = #{params[:active_code]}").first
    # binding.pry
    if @check
      return @check
    else
      return false
    end
  end

  def hash_field
    # binding.pry
    if self.password == "" || self.password == nil
      self.password = User.find(self.id).password
    else
      self.password = Digest::MD5.hexdigest(self.password)
    end

  end

  def self.from_omniauth(auth,current_user = nil)
    # binding.pry
    # check login
    if current_user != nil
      @user = User.find(current_user.id)
      @user.facebook_id = auth.uid
      @user.save
    else
      check = self.find_by_facebook_id(auth.uid)
      if check
        @user = check
      else
        @user = User.new
        @user.email = SecureRandom.hex(9)+"@mail.com"
        @user.provider = auth.provider
        @user.uid = auth.uid
        @user.facebook_id = auth.uid
        @user.name = auth.info.name
        @user.oauth_token = auth.credentials.token
        @user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        @user.by_social = 1
        @user.change_email = 0
        @user.status = 0
        @user.save
      end
      # binding.pry
    end
    return @user


  end

  def self.from_omniauth_google(auth,current_user = nil)
    if current_user != nil
      @user = User.find(current_user.id)
      @user.google_id = auth.uid
      @user.save
    else
      check = self.find_by_google_id(auth.uid)
      if check
        @user = check
      else
        @user = User.new
        @user.email = auth.info.email
        @user.provider = auth.provider
        @user.google_id = auth.uid
        @user.name = auth.info.name
        @user.oauth_token = auth.credentials.token
        @user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        @user.status = 0
        @user.by_social = 1
        @user.change_email = 0
        # binding.pry
        @user.save
      end
    end
    return @user
  end
end
