# Start SimpleCov before anything else
require "simplecov"

SimpleCov.start "rails" do
  add_filter "/bin/"
  add_filter "/db/"
  add_filter "/config/"
  add_filter "/test/"  # Exclude test files themselves
end

# Ensure SimpleCov merges coverage results correctly when using parallel tests
if ENV["PARALLEL_WORKERS"]
  SimpleCov.at_exit do
    SimpleCov.result.format!
  end
end

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end
