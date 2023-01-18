module EntityReport
	module Errors
		class InvalidError < EntityReport::Errors::Error
			def as_jsonapi_errors
				return super if errors.nil?

				errors.map do |err|
					{
						title: title_for(err),
						code: code_for(err),
						detail: detail_for(err),
						source: source_for(err)
					}
				end
			end

			def http_status_code
				400
			end

		private

			def errors
				@errors&.errors
			end

			def title_for(error)
				"Invalid #{error.attribute.to_s.camelcase}"
			end

			def code_for(error)
				"#{@error_name}.#{error.attribute}.#{error.type}"
			end

			def detail_for(error)
				"#{error.attribute.to_s.gsub('_', ' ').capitalize} #{error.message}"
			end

			def source_for(error)
				{ pointer: "/attribute/#{error.attribute}" }
			end
		end
	end
end
