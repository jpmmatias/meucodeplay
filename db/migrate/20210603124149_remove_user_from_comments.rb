class RemoveUserFromComments < ActiveRecord::Migration[6.1]
	def change
		remove_column :comments, :user_id
	end
end
