class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :rooms do |t|
      t.integer :recruit_id, null: false
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :rooms, [:user_id, :recruit_id], unique: true
  end
end
