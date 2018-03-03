Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, Rails.application.secrets.fb_omniauth_provider_key, Rails.application.secrets.fb_omniauth_provider_secret
  provider :google_oauth2, Rails.application.secrets.google_omniauth_provider_key,Rails.application.secrets.google_omniauth_provider_secret
end
