# Prevent database truncation if the environment is production

ENV['RAILS_ENV'] = 'test'

require 'active_record'
require 'spec_helper'
require 'rspec/rails'
require 'shoulda/matchers'


Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared_examples/**/*.rb')].each { |f| require f }
Dir[Rails.root.join('spec/shared_context/**/*.rb')].each { |f| require f }


Shoulda::Matchers.configure do |config|
	config.integrate do |with|
		with.test_framework :rspec
		with.library :rails
	end
end

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'support'))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), 'shared_examples'))

RSpec.configure do |config|
  config.include Helpers
  config.extend Requests
  config.include Requests
end
