RSpec.shared_examples 'responds with the correct body' do
	it 'responds with the correct body' do
		send_request
		expect_object_response
	end
end
