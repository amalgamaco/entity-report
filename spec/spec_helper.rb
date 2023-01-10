# Configure Rails Environment
ENV["RAILS_ENV"] = "test"
require 'rspec'
require 'byebug'
require 'devise'
require 'doorkeeper'
require 'factory_bot_rails'
require 'active_record'

require_relative '../spec/support/helpers'
require_relative '../spec/shared_examples/for_interactors'
require_relative '../spec/shared_contexts/for_controllers'

ActiveRecord::Migrator.migrations_paths = [File.expand_path("../spec/dummy/db/migrate", __dir__)]

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))


RSpec.configure do |config|
	config.include FactoryBot::Syntax::Methods

	config.expect_with :rspec do |expectations|
		expectations.include_chain_clauses_in_custom_matcher_descriptions = true
	end

	config.mock_with :rspec do |mocks|
		mocks.verify_partial_doubles = true
	end
end