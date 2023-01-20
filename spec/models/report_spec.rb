require 'rails_helper'

RSpec.describe Report, type: :model do
	subject { create(:report, reportable:) }

	let(:reportable) { create(:user) }

	it { is_expected.to have_db_column(:reportable_id).of_type(:integer) }
	it { is_expected.to have_db_column(:reportable_type).of_type(:string) }
	it { is_expected.to have_db_column(:description).of_type(:text) }
	it { is_expected.to have_db_column(:reason).of_type(:string) }

	it { is_expected.to belong_to(:reportable) }
	it { is_expected.to belong_to(:user) }

	it { is_expected.to respond_to :reportable_type }
	it { is_expected.to respond_to :reportable_id }
	it { is_expected.to respond_to :user_id }

	describe 'custom validations' do
		context 'when reason is invalid' do
			before { allow(reportable).to receive(:valid_reason?).and_return(false) }

			it 'raises invalid error' do
				expect do
					create :report, reportable:
				end.to raise_error(EntityReport::Errors::InvalidError)
			end
		end

		context 'when description is needed but not given' do
			before { allow(reportable).to receive(:description_needed?).and_return(true) }

			it 'raises invalid error' do
				expect do
					create :report, reportable:, description: ''
				end.to raise_error(EntityReport::Errors::InvalidError)
			end
		end
	end
end
