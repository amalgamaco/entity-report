FactoryBot.define do
	factory :user do
		sequence(:email, Random.rand(1..30_000)) { |n| "example#{n}@example.com" }
		sequence(:password) { |n| "password-#{n}" }
	end
end
