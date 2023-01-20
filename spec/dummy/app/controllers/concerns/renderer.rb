
	module Renderer
		include EntityReport::Errors
		
		def render_successful_response(object, serializer, options = {})
			serializer_options = options.empty? ? {} : options[:serializer_options]
			render_options = {}.merge(
					{
						json: object_json(object, serializer, serializer_options),
						root: 'response',
						adapter: :json,
						status: 200
					}, options
			)
			render render_options
		end
		
		def render_successful_empty_response
			render_response_message hash: { status: 'successful' }, status: 200
		end

		def render_response_message(hash:, status:)
			render json: { 'response' => hash }, adapter: :json, status: status
		end

		def render_failed_response(exception_array, status)
			render json: { 'errors' => exception_array }, adapter: :json, status: status
		end

		def render_include_error(exception)
			render_error UnsupportedIncludeError.new :unsupported_include, exception.message, exception
		end

		def render_record_not_found(exception)
			render_error NotFoundError.new :not_found, exception.message, exception
		end

		def render_invalid_record_attribute(exception)
			render_error UnprocessableError.new(
					:invalid_record_attribute, :unprocessable, exception.record.errors
			)
		end

		def render_standard_error(exception)
			render_error Error.new :error, exception.message
		end

		def render_error(exception)
			render_failed_response exception.message, exception.http_status_code
		end

		def render_empty_response
			render json: {}, adapter: :json, status: :no_content
		end
		
private
	
		def object_json(object, serializer, serializer_options)
			options = serializer_options_for(object, serializer_options)
			serializer.new(object, options).serializable_hash.to_json
		end

		def serializer_options_for(object, base_serializer_options)
			return {} if object.nil?
			base_serializer_options.merge(
				cursor_serializer_options_for(object)
			)
		end

		def cursor_serializer_options_for(object)
			return {} unless object_can_be_cursor_paginated?(object)
			{
				meta: {
					page: {
						prev: object.first.cursor,
						next: object.last.cursor
					}
				}
			}
		end

		def object_can_be_cursor_paginated?(object)
			object.respond_to?(:to_a) && object.to_a.first.try(:respond_to?, :cursor)
		end
	end
