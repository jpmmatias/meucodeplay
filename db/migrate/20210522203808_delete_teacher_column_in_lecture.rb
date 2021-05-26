class DeleteTeacherColumnInLecture < ActiveRecord::Migration[6.1]
	def change
		remove_column :lectures, :teacher_id
		add_reference :lectures,
		              :course,
		              index: true,
		              foreign_key: true,
		              null: false
		#Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
	end
end
