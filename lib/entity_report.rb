require 'rails'
require 'active_support/dependencies'
require 'entity_report/version'
require 'entity_report/engine'

module EntityReport
	module Controllers
		autoload :ReportsController, 'entity_report/controllers/reports_controller'
	end

	module Interactors
		autoload :CreateReport, 'entity_report/interactors/create_report'
		autoload :ApplicationInteractor, 'entity_report/interactors/application_interactor'
	end
	
	module Modules
		autoload :Reportable, 'entity_report/modules/reportable'
		autoload :ErrorRaiser, 'entity_report/modules/error_raiser'
		autoload :Renderer, 'entity_report/modules/renderer'
		autoload :ApiHandlers, 'entity_report/modules/api_handlers'
	end

	module Serializers
		autoload :ReportSerializer, 'entity_report/serializers/report_serializer'
	end

	module Generators
		autoload :InstallGenerator, 'generators/entity_report/install_generator.rb'
	end

	module Errors
		autoload :Error, 'entity_report/errors/error'
		autoload :NotFoundError, 'entity_report/errors/not_found_error'
		autoload :UnprocessableError, 'entity_report/errors/unprocessable_error'
		autoload :InvalidError, 'entity_report/errors/invalid_error'
		autoload :MethodRequiredError, 'entity_report/errors/method_required_error'
	end
end
