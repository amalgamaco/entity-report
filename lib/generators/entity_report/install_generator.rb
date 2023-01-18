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
			
			def create_mailer
				copy_file "report_mailer.rb", "app/mailers/report_mailer.rb"
			end

			def create_email
				copy_file "report_email_template.rb", "app/views/report_mailer/report_email.html.erb"
			end

			def create_text_email
				copy_file "report_email_only_text.rb", "app/views/report_mailer/report_email.text.erb"
			end
		
			def migration_version
				"[#{ActiveRecord::VERSION::MAJOR}.#{ActiveRecord::VERSION::MINOR}]"
			end
		end
	end
end