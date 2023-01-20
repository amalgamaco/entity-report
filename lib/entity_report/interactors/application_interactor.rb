module EntityReport
	module Interactors
		class ApplicationInteractor
			# [IMP] - En principio esta clase no sería necesaria y podríamos agregar esto
			# directamente al único interactor que tenemos. Igual si pensamos agregar
			# interactors para obtener una lista de reports / obtener un report entonces
			# se puede quedar. :P
			include ActiveModel::Validations
			include EntityReport::Modules::ErrorRaiser

		private

			def transaction(&block)
				ActiveRecord::Base.transaction(&block)
			end
		end
	end
end
