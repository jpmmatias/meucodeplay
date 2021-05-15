class AddBioToTeachers < ActiveRecord::Migration[6.1]
	def change
		remove_column :teachers, :description
		add_column :teachers, :bio, :string
	end
end
