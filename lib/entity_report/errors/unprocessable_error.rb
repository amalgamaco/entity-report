module EntityReport
	module Errors
		class UnprocessableError < EntityReport::Errors::Error

			def http_status_code
				422
			end
		end
	end
end

