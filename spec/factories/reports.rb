FactoryBot.define do
	factory :report do
		sequence(:description) { |n| "An example description #{n}" }
		reason { 'spam' }
		reportable { build :user }
		user
	end
end