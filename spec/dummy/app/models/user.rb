class User < ApplicationRecord

	include EntityReport::Modules::Reportable
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

	has_many :access_grants,
		class_name: 'Doorkeeper::AccessGrant',
		foreign_key: :resource_owner_id,
		dependent: :delete_all # or :destroy if you need callbacks

	has_many :access_tokens,
			class_name: 'Doorkeeper::AccessToken',
			foreign_key: :resource_owner_id,
			dependent: :delete_all

	def reportable_by_user?(user_id:)
		user_id != self.id
	end
end
