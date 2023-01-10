require 'rails'
require 'active_support/dependencies'
require 'entity_report/version'
require 'entity_report/engine'

module EntityReport
	module Controllers
		autoload :ReportController, 'entity_report/controllers/reports_controller'
	end

	module Interactors
		autoload :ReportEntity, 'entity_report/interactors/report_entity'
	end

	module Generators
		autoload :InstallGenerator, 'generators/entity_report/install_generator.rb'
	end
end
