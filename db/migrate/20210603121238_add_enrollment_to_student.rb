class AddEnrollmentToStudent < ActiveRecord::Migration[6.1]
	def change
		add_reference :enrollments, :student, null: false, foreign_key: true
		remove_column :enrollments, :user_id
		remove_column :enrollments, :user
	end
end
