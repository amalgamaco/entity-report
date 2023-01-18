require "rails/generators/active_record"

module EntityReport
	module Generators
		class InstallGenerator < Rails::Generators::Base
			include ActiveRecord::Generators::Migration

			source_root File.join(__dir__, "templates")

			def copy_migration
				migration_template "reports_migration.rb", "db/migrate/create_reports.rb", migration_version: migration_version
			end

			def create_model
				copy_file "report_model.rb", "app/models/report.rb"
			end
		
			def migration_version
				"[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
			end
		end
	end
end