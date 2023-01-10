RSpec.shared_examples 'raises Error exception' do |exception_type|
	it {
		expect { call_interactor }.to raise_exception exception_type
	}
end

