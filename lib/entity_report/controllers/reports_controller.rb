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
				# [HIGH] - Si sacamos el serializer entonces acá deberíamos llamar a otro método, tipo
				# render_report que debería ir en REQUIRED_METHODS y que deberíamos pedir que
				# implementen para que funcione. Ver comentario que deje en el serializer.
				render_successful_response CreateReport
						.with(
							current_user: current_user,
							report_mailer: report_mailer,
							report_attributes: report_attributes,
							report_klass: report_klass
						), ReportSerializer
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