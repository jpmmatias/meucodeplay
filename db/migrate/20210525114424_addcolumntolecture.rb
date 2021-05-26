class Addcolumntolecture < ActiveRecord::Migration[6.1]
	def change
		add_column :lectures, :content, :text
	end
end
