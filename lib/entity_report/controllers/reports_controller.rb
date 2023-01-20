module EntityReport
	module Controllers
		module ReportsController
			extend ActiveSupport::Concern
			include EntityReport::Interactors
			
			REQUIRED_METHODS = [ :current_user, :report_klass, :report_mailer, :render_report ]

			def create
				render_report CreateReport
						.with(
							current_user: current_user,
							report_mailer: report_mailer,
							report_attributes: report_attributes,
							report_klass: report_klass
						)
			end

			# [IMP] - Como improvement podríamos proveer:
			# - un index donde se listen los reports que hizo el current_user y que se pueda
			#   filtrar por reportable_type
			# - un show para mostrar un report particular

			# También estaría buen tener un módulo que 

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