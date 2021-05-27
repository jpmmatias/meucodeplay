class AddSlugToTeachers < ActiveRecord::Migration[6.1]
  def change
    add_column :teachers, :slug, :string
    add_index :teachers, :slug, unique: true
  end
end
