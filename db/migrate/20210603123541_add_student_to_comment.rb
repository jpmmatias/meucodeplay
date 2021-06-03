class AddStudentToComment < ActiveRecord::Migration[6.1]
	def change
		add_reference :comments, :student, null: false, foreign_key: true
		remove_column :comments, :user
	end
end
