# rubocop:disable Style/RescueModifier
module EntityReport
	module Modules
		module ApiHandlers
			# [HIGH] - Esto no lo proporcionaría, sino que lo pondría en el ejemplo para que lo hagan
			# en cada proyecto como quieran
			extend ActiveSupport::Concern
			included do
					rescue_from ::StandardError, with: :render_standard_error
					rescue_from EntityReport::Errors::Error, with: :render_error
					rescue_from ::ActiveRecord::RecordNotFound, with: :render_record_not_found
					rescue_from ::ActiveRecord::RecordInvalid, with: :render_invalid_record_attribute
			end
		end
	end
end
# rubocop:enable Style/RescueModifier
