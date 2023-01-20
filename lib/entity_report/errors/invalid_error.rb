module EntityReport
	module Errors
		class InvalidError < EntityReport::Errors::Error
			def http_status_code
				400
			end
		end
	end
end