ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'support/factory_bot'
require 'support/json_response_helper'
require 'faker'

include Auth::JsonWebTokenHelper
include JsonResponseHelper
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |config_matchers|
    config_matchers.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
