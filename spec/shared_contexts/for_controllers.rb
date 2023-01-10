RSpec.shared_context 'when using doorkeeper' do
	let(:token) { instance_double 'doorkeeper_token' }
	let(:current_user) { create :user }

	before do
		allow(token).to receive(:acceptable?).and_return(true)
		allow(controller).to receive(:doorkeeper_token) { token }
		allow(controller).to receive(:current_user) { current_user }
	end
end
