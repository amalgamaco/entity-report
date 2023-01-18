module EntityReport
	module Errors
		class MethodRequiredError < StandardError
			def initialize(method, klass)
				super "The #{method} is required and must be implemented in class #{klass}"
			end
		end
	end
end
