# frozen_string_literal: true

require_relative "lib/entity_report/version"

Gem::Specification.new do |spec|
  spec.name          = "entity_report"
  spec.version       = EntityReport::VERSION
  spec.authors       = ["Juan Fernando Urquijo"]
  spec.email         = ["juanfernando@amalgama.co"]

  spec.summary       = "Provides the elements to implement the report functionality"
  spec.description   = ""
  spec.homepage      = "https://git.amalgama.co/amalgama/packages/gems/entity-report"
  spec.required_ruby_version = Gem::Requirement.new(">= 3.0.0")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://git.amalgama.co/amalgama/packages/gems/entity-report"
  spec.metadata["changelog_uri"] = "https://git.amalgama.co/amalgama/packages/gems/entity-report/changelog"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
		Dir['{app,config,db,lib}/**/*', 'Rakefile', 'README.md']
	end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'rails', '>= 7.0.3.1'
	spec.add_dependency 'rake'
	spec.add_dependency 'rspec'
	spec.add_dependency 'rswag'
	spec.add_dependency 'rspec-rails'
	spec.add_dependency 'bundler'
	spec.add_dependency 'openssl'
	spec.add_dependency 'jsonapi.rb'

	spec.add_dependency('railties', '>= 5.2.0') # encrypted credentials
	spec.add_development_dependency 'test-unit-rails'
	spec.add_development_dependency 'rubocop-rails'
	spec.add_development_dependency 'byebug'
	spec.add_development_dependency 'factory_bot_rails'
	spec.add_development_dependency 'shoulda-matchers'

	spec.add_development_dependency 'doorkeeper'
	spec.add_development_dependency 'config'
	spec.add_development_dependency 'devise'

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
