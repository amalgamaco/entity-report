module EntityReport
	module Serializers
		class ReportSerializer
			include JSONAPI::Serializer
			
			attributes :reportable_id, :reportable_type, :reason, :description, :created_at
			
		end
	end
end