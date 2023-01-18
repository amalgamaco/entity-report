module EntityReport
	module Controllers
		module ReportsController
			extend ActiveSupport::Concern
			include EntityReport::Modules
			include EntityReport::Interactors
			include EntityReport::Serializers
			include Renderer
			include ErrorRaiser
			include ApiHandlers
			
			def create
				render_successful_response CreateReport
						.with(
							current_user: current_user,
							report_mailer: report_mailer,
							report_attributes: report_attributes,
							report_klass: report_klass
						), ReportSerializer
			end

		private

			def report_attributes
				params.permit(:reportable_type, :reportable_id, :reason, :description)
			end

			def report_klass
				method_required( :report_klass, self)
			end

			def report_mailer
				method_required( :report_mailer, self)
			end
		end
	end
end