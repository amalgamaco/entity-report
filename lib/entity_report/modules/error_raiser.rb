
module EntityReport
	module Modules
		module ErrorRaiser

			include EntityReport::Errors

			def error(error_name, error_message, error = Error, error_record = nil, attribute = nil)
				raise error.new error_name, error_message, error_record, attribute
			end

			def invalid(exception_name, exception_message)
				error "invalid.#{exception_name}", exception_message, InvalidError, nil, exception_name
			end

			def not_found(exception_name, exception_message)
				error "not_found.#{exception_name}", exception_message, NotFoundError
			end

			def unprocessable(exception_name, exception_message)
				error "unprocessable.#{exception_name}", exception_message, UnprocessableError, nil, exception_name
			end

			def method_required(method, klass)
				raise MethodRequiredError.new(method, klass)
			end
		end
	end
end