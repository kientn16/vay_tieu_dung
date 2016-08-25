# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.public_key  = '6LdbYygTAAAAALicCMBQvUrXkZQQM8WlWXYbtKX4'
  config.private_key = '6LdbYygTAAAAAEwc0ZySomlLuHleeVotMTXQq_UU'
  # Uncomment the following line if you are using a proxy server:
  # config.proxy = 'http://myproxy.com.au:8080'
end