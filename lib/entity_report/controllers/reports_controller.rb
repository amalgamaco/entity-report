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
			
			REQUIRED_METHODS = [ :current_user, :report_klass, :report_mailer ]

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

			def method_missing(method, *args, &block)
				raise MethodRequiredError.new(method, self.class) if REQUIRED_METHODS.include? method
				super
			end
		end
	end
end