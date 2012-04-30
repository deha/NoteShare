class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :first_name
      t.string :last_name_text

      t.timestamps
    end
  end
end
