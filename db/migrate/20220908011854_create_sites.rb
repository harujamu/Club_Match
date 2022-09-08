class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.integer :user_id, null: false
      t.integer :prefecture, null: false
      t.string :municipality, null: false
      t.string :address, null: false
      t.timestamps
    end
  end
end
