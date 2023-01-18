require 'swagger_helper'

RSpec.describe '/reports', type: :request do
	let!(:current_user) { create :user }
	let(:serializer) do
		EntityReport::Serializers::ReportSerializer.new(created_report, {
			params: { current_user_id: current_user.id }
		})
	end

	path '/reports' do
		post 'Create report for type' do
			tags 'Reports'
			description 'Creates a report for type'

			parameter name: :report_params, in: :body, schema: {
				type: :object,
				properties: {
					reportable_type: { type: :string, enum: Report::REPORTABLE_TYPES },
					reportable_id: { type: :integer, format: :int64 },
					reason: { type: :string },
					description: { type: :string }
				},
				required: %i[reportable_id reportable_type reason]
			}

			security [ oauth_token: [] ]
			include_context 'with user authenticated'


			let(:reportable) { create :user }
			let(:reportable_id) { reportable.id }
			let(:reportable_type) { reportable.class.name }
			let(:created_report) { Report.last }
			let(:current_user) { create :user }
			let(:description) { "blablabla" }
			let(:reason) { 'other' }

			let!(:report_params) {
				{
					description: description,
					reason: reason,
					reportable_id: reportable_id,
					reportable_type: reportable_type
				}
			}

			response(200, 'successful') do
				before do |example|
					submit_request(example.metadata)
				end
				
				it 'returns a valid 201 response' do |example|
					assert_response_matches_metadata(example.metadata)
				end
			end

			response(400, 'Invalid params') do
				let(:reason){ nil }
				include_context 'swagger setup and run test'
			end

			response(404, 'Reportable not found') do
				let(:reportable_id) { User.last.id + 10 }
				include_context 'swagger setup and run test'
			end
		end
	end
end