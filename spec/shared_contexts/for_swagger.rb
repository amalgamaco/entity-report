RSpec.shared_context 'swagger setup and run test' do
	after do |example|
		json_response = response.code != '204' ? JSON.parse(response.body, symbolize_names: true) : ''

		example.metadata[:response][:content] = {
			'application/json' => {
				example: json_response
			}
		}
	end

	run_test!
end
