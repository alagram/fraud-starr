# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rspec'
require 'capybara/email/rspec'

OmniAuth.config.test_mode = true

omniauth_twitter_hash = {
  provider: "twitter",
  uid: "123456",
  info: {
    nickname: "kofialbert",
    name: "Albert Smith"
   },
   credentials: {
    token: "a1b2c3d4",
    secret: "abcd1234"
   },
}

omniauth_facebook_hash = {
  provider: "facebook",
  uid: "123456",
  info: {
    nickname: "kofialbert",
    email: "albert@example.com",
    first_name: "Albert",
    last_name: "Smith"
   },
   credentials: {
    token: "a1b2c3d4",
    expires_at: 1392246275,
    expires: true
   },
}

OmniAuth.config.add_mock(:twitter, omniauth_twitter_hash)
OmniAuth.config.add_mock(:facebook, omniauth_facebook_hash)

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
