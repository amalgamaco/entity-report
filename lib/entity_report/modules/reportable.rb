# frozen_string_literal: true

module EntityReport
	module Modules
		module Reportable
			extend ActiveSupport::Concern

			included do
				has_many :reports, as: :reportable, dependent: :destroy

				def reportable_by_user?(user_id:)
					raise NotImplementedError
				end

				def valid_reason?(reason)
					self.reportable_reasons.include?(reason)
				end

				def description_needed?(reason)
					reason == 'other'
				end

				def reportable_reasons
					%w[
						inappropriate_language
						inappropriate_content
						spam
						other
					].freeze
				end
			end
		end
	end
end
