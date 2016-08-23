OmniAuth.config.logger = Rails.logger
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '1094818193933880', '200720e7ef5d8dca78c4b2d9c27cb8d1', scope: 'email,user_birthday', display: 'popup'
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '418635000592-m0i09fklhcircaakk93fknqe9j6d4mno.apps.googleusercontent.com', '-MSkybstfQoxRJv7DqwxLFhj', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end