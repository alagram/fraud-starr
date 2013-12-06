# OmniAuth.congif.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
  provider :identity, fields: [:email, :full_name], model: User, on_failed_registration: lambda { |env|
    UsersController.action(:new).call(env)
  }
end