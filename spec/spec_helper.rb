require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run :focus => true
    config.run_all_when_everything_filtered = true
    config.include FactoryGirl::Syntax::Methods
  end
end

Spork.each_run do
  FactoryGirl.reload
end

RSpec.configure do |config|
  OmniAuth.config.test_mode = true
  pre = {provider:'facebook', uid:"123456", info:{name:'Test Name', nickname:'testuser', email:'test@user.com'}, credentials:{token:'abc123', expires_at:1341979183}}
  OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(pre)
end
