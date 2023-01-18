module EntityReport
	module Interactors
		class ApplicationInteractor
			include ActiveModel::Validations
			include EntityReport::Modules::ErrorRaiser

		private

			def transaction(&block)
				ActiveRecord::Base.transaction(&block)
			end
		end
	end
end
