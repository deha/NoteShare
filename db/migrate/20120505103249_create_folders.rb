class CreateFolders < ActiveRecord::Migration
  def change
    create_table :folders do |t|
      t.integer :parent_id
      t.string :name
      t.text :description
      t.string :level

      t.timestamps
    end
    
    add_index :folders, :parent_id
  end
end
