module Helpers
	def parsed_body(response)
		JSON.parse response.body
	end
end
