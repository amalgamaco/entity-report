module EntityReport
	module Serializers
		# [HIGH] - Creo que esto tampoco lo proveería para evitar acoplarnos a JSONApi
		class ReportSerializer
			include JSONAPI::Serializer
			
			attributes :reportable_id, :reportable_type, :reason, :description, :created_at
			
		end
	end
end