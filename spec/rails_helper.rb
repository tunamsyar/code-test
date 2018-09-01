ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'
require 'rake'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
ActiveRecord::Migration.maintain_test_schema!
ActiveJob::Base.queue_adapter = :test

RSpec.configure do |config|
  config.use_transactional_fixtures = false

  config.include ApiHelper
  config.include Requests::JsonHelpers
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include ApiLoginHelpers, type: :request
end
