class Addtimetolessons < ActiveRecord::Migration[6.1]
	def change
		add_column :lectures, :time, :integer
	end
end
