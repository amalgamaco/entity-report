module EntityReport
	module Errors
		class Error < StandardError
			attr_reader :error_name, :error_message, :errors, :attribute

			def initialize(error_name, error_message, errors = nil, attribute = nil)
				super "#{error_name}: #{error_message}"

				@error_name = error_name
				@error_message = error_message
				@errors = errors
				@attribute = attribute
			end

			def as_jsonapi_errors
				[
					{
						title: title,
						code: @error_name,
						detail: @error_message,
						source: { pointer: source }
					}
				]
			end

			def http_status_code
				400
			end

		private

			def title
				self.class.to_s.underscore.titleize
			end

			def source
				return "/attribute/#{attribute}" if attribute.present?

				nil
			end
		end
	end
end
