module EntityReport
	module Errors
		class NotFoundError < EntityReport::Errors::Error
			def http_status_code
				404
			end

		private

			def model
				@errors&.model
			end

			def code
				model.nil? ? super : "#{super}.#{model&.downcase}"
			end

			def source
				model && "/#{model}/#{@errors&.primary_key}"
			end
		end
	end
end
