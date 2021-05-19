class CreateTeachers < ActiveRecord::Migration[6.1]
	def change
		drop_table :users
		create_table :teachers do |t|
			t.string :email
			t.text :description

			t.timestamps
		end
	end
end
