module EntityReport
	module Interactors
		class CreateReport < EntityReport::Interactors::ApplicationInteractor

			def self.with(report_attributes:, report_mailer:, current_user:, report_klass:)
				new(
					report_mailer: report_mailer,
					report_attributes: report_attributes,
					current_user: current_user,
					report_klass: report_klass
				).execute
			end

			def initialize(report_attributes:, current_user:, report_mailer:, report_klass:)
				super()

				@report_mailer = report_mailer
				@report_attributes = report_attributes
				@current_user = current_user
				@report_klass = report_klass
			end

			def execute
				validate_report_attributes

				transaction do
					create_report
					send_email
				end

				@report
			end

		private


			def validate_report_attributes
				validate_missing_params
				validate_reportable_type
				validate_current_user_can_report_reportable
			end

			def validate_missing_params
				%i[reportable_type reportable_id reason].each do |param|
					invalid param, "#{param} attribute missing" if @report_attributes[param].nil?
				end
			end

			def validate_reportable_type
				invalid :reportable_type, "Class #{reportable_type} is not reportable" \
					unless @report_klass.valid_reportable_type?(reportable_type)
			end

			def validate_current_user_can_report_reportable
				unprocessable :reportable, 'Current user cannot report the given reportable' \
					unless reportable.reportable_by_user?(user_id: @current_user.id)
			end

			def create_report
				@report = @report_klass.create!(
					reportable_type: reportable_type,
					reportable_id: reportable_id,
					description: description,
					reason: reason,
					user_id: @current_user.id
				)
			end

			def send_email
				@report_mailer.with(report: @report).report_email.deliver_later
			end

			def reportable_klass
				begin
					return reportable_type.camelize.constantize
				rescue NameError
					invalid :reportable_type, "#{reportable_type} is not a valid reportable_type"
				end
			end

			def reportable_type
				@report_attributes[:reportable_type]
			end

			def reportable_id
				@report_attributes[:reportable_id]
			end
				
			def description
				@report_attributes[:description]
			end
				
			def reason
				@report_attributes[:reason]
			end

			def reportable
				@reportable ||= reportable_klass.find(reportable_id)
			end
		end
	end
end

