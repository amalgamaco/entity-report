require 'rails_helper'

RSpec.shared_examples 'CreateReport is successful' do
	it 'creates a new report' do
		expect { call_interactor }.to change(Report, :count).by(1)
				.and change(ActionMailer::Base.deliveries, :count).by(1)
	end
end

RSpec.shared_examples 'CreateReport fails' do |error = EntityReport::Errors::NotFoundError|
	it 'not creates a new report' do
		expect { call_interactor }.to raise_error(error)
				.and change(Report, :count).by(0)
				.and change(ActionMailer::Base.deliveries, :count).by(0)
	end
end

RSpec.describe EntityReport::Interactors::CreateReport do
	let(:reportable) { create(:user) }
	let(:reportable_type) { reportable.class.name }
	let(:reportable_id) { reportable.id }
	let!(:current_user) { create(:user) }
	let(:description) { "a description" }
	let(:reason) { 'inappropriate_content'}
	let(:report_klass) { Report }
	let(:report_mailer) { ReportMailer }

	let(:report_attributes) do
		{
			description: description,
			reportable_type: reportable_type,
			reportable_id: reportable_id,
			reason: reason,
			user_id: current_user.id
		}
	end

	let(:call_interactor) do
		described_class.with(
			report_attributes: report_attributes,
			current_user: current_user,
			report_klass: report_klass,
			report_mailer: report_mailer
		)
	end

	context 'with correct params' do
		include_examples 'CreateReport is successful'
	end

	context 'when reporting a user' do

		include_examples 'CreateReport is successful'

		context "when user doesn't exists" do
			let(:reportable_id) { User.last.id + 1 }
			let(:reportable_type) { 'User' }

			include_examples 'CreateReport fails', ActiveRecord::RecordNotFound
		end

		context 'when reporting itself' do
			let(:reportable) { current_user }

			include_examples 'CreateReport fails', EntityReport::Errors::UnprocessableError
		end
	end

	context 'with missing params' do
		context 'without reportable_type' do
			let(:reportable_type) { nil }

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end

		context 'without reportable_id' do
			let(:reportable_id) { nil }

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end

		context 'without reason' do
			let(:reason) { nil }

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end

		context 'without reason' do
			let(:reason) { nil }

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end
	end

	context 'with invalid params' do
		
		context 'with invalid reportable_type' do
			let(:reportable_type) { 'invalid_class' }

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end

		context 'with invalid reason' do
			let(:reason) { 'anything' } 

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end

		context 'when description is needed but not given' do
			let(:reason) { 'other' }
			let(:description) { '' }

			include_examples 'CreateReport fails', EntityReport::Errors::InvalidError
		end
	end
end