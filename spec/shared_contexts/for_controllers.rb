RSpec.shared_context 'when using doorkeeper' do
	let(:token) { instance_double 'doorkeeper_token' }
	let(:current_user) { create :user }

	before do
		allow(token).to receive(:acceptable?).and_return(true)
		allow(controller).to receive(:doorkeeper_token) { token }
		allow(controller).to receive(:current_user) { current_user }
	end
end

# rubocop:disable RSpec/VariableName
RSpec.shared_context 'with user authenticated' do
	let(:current_client) { Doorkeeper::Application.create(name: 'api test client', redirect_uri: '', scopes: 'api') }
	let(:Authorization) { "Bearer #{auth_token_for_requests(current_user, current_client)}" }
end
# rubocop:enable RSpec/VariableName
