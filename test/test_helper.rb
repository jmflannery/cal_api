ENV["RAILS_ENV"] ||= "test"
# Consider setting MT_NO_EXPECTATIONS to not add expectations to Object.
# ENV["MT_NO_EXPECTATIONS"] = "true"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require 'database_cleaner/active_record'

DatabaseCleaner.strategy = :transaction

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ApiIntegrationTestCase < ActiveSupport::TestCase
  include Rack::Test::Methods

  def app
    Rack::Builder.parse_file('config.ru')
  end

  register_spec_type(/\w+\s?API$/i, self)

  def before_setup
    super
    DatabaseCleaner.clean
    DatabaseCleaner.start
  end
end
