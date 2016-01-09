# Configure Omniauth to use Rails logger
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer, uid_field: :uid, fields: [:uid, :email] if Rails.env.development?
end
