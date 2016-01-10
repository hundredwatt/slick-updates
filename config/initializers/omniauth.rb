# Configure Omniauth to use Rails logger
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, uid_field: :uid, fields: [:uid, :email] if Rails.env.development?
  provider :google_oauth2, ENV["GOOGLE_OAUTH2_CLIENT_ID"], ENV["GOOGLE_OAUTH2_CLIENT_SECRET"], name: 'google'
end
