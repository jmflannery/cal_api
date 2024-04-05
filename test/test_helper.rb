ENV["RAILS_ENV"] ||= "test"
ENV["MT_NO_EXPECTATIONS"] = "true"

require_relative "../config/environment"
require "rails/test_help"
require "minitest/rails"
require "minitest/pride"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
    
    include FactoryBot::Syntax::Methods
  end
end

class ApiIntegrationTestCase < ActiveSupport::TestCase
  include Rack::Test::Methods

  register_spec_type(/\w+\s?API$/i, self)

  register_spec_type(self) do |_desc, *addl|
    addl.include? :api
  end

  def app
    Rack::Builder.parse_file('config.ru')
  end
end
