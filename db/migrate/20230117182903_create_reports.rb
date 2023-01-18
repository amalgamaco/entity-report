class CreateReports < ActiveRecord::Migration[7.0]
	def change
		create_table :reports do |t|
			t.references :reportable, null: false, polymorphic: true
			t.string :reason, null: false
			t.text :description			
			t.references :user, null: false, foreign_key: true

			t.index [:user_id, :reportable_type, :reportable_id], unique: true
			t.index [:reportable_type, :reportable_id]

			t.timestamps
		end
	end
end