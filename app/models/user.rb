class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  def self.check_active_code(params)
    @check = User.where("email = '#{params[:email]}' AND active_code = #{params[:active_code]}").first
    # binding.pry
    if @check
      return @check
    else
      return false
    end
  end

  def self.from_omniauth(auth)
    # binding.pry
    check = self.find_by_facebook_id(auth.uid)

    if check
      @user = User.find_by_facebook_id(auth.uid)
    else
      @user = User.new
    end
    @user.email = SecureRandom.hex(9)+"@mail.com"
    @user.provider = auth.provider
    @user.uid = auth.uid
    @user.facebook_id = auth.uid
    @user.name = auth.info.name
    @user.oauth_token = auth.credentials.token
    @user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    @user.status = 1
    # binding.pry
    if @user.save
      return @user
    end
  end

  def self.from_omniauth_google(auth)
    check = self.find_by_google_id(auth.uid)
    if check
      @user = User.find_by_google_id(auth.uid)
    else
      @user = User.new
    end
    @user.email = auth.info.email
    @user.provider = auth.provider
    @user.google_id = auth.uid
    @user.name = auth.info.name
    @user.oauth_token = auth.credentials.token
    @user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    @user.status = 1
    # binding.pry
    if @user.save
      return @user
    end
  end
end
