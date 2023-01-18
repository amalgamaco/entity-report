module Requests
	def auth_token_for(user)
		Doorkeeper::AccessToken.create!(resource_owner_id: user.id).token
	end

	def auth_token_for_requests(user, client)
		post oauth_token_url, params: {
			grant_type: 'password',
			username: user.username,
			password: user.password,
			client_id: client.uid,
			client_secret: client.secret
		}, as: :json

		JSON(response.body)['access_token']
	end

	def response_properties(model)
		{
			response: {
				'$ref': "#/definitions/#{model}"
			}
		}
	end

	def object_response_schema(model)
		{ type: :object, properties: response_properties(model), required: [ :response ] }
	end

	def send_request
		submit_request(self.class.example_group.metadata)
	end

	def expect_object_response
		expect_response(serializer.serializable_hash)
	end

	def expect_raw_response
		expect_response(response_body)
	end

	def expect_response(response_hash)
		assert_response_matches_metadata(self.class.example.metadata)
		expect_equivalent_json_strings(response.body, response_hash.to_json)
	end

	def expect_equivalent_json_strings(left_json, right_json)
		expect(JSON.parse(left_json)).to eq JSON.parse(right_json)
	end

	def error_schema(*names_with_messages)
		response_schema =
				if names_with_messages.length == 1
					error_name_with_message_schema(names_with_messages.first)
				else
					{ oneOf: names_with_messages.map do |name_with_message|
						error_name_with_message_schema(name_with_message)
					end }
				end
		{ type: :object, properties: { response: response_schema }, required: [ :response ] }
	end

	def error_name_with_message_schema(name_with_message)
		{
			type: :object,
			properties: {
				error_name: { type: :string, enum: [ name_with_message[:name] ] },
				error_message: { type: :string, enum: [ name_with_message[:message] ] }
			},
			required: %i[error_name error_message]
		}
	end

	def invalid_record_schema
		{
			type: :object,
			properties: { response: { '$ref': '#/components/schemas/invalid_record_error' } },
			required: [ :response ]
		}
	end

	def collection_response_properties(model)
		{
			response: {
				type: 'array',
				items: { '$ref': "#/components/schemas/#{model}" }
			}
		}
	end

	def permission_denied_schema
		error_schema name: 'permission_denied', message: "You don't have permission to perform this action"
	end
end
