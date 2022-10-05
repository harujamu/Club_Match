class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|

      t.integer :user_id, null: false
      t.integer :recruit_id, null: false
      t.integer :entry_status, null: false, default: 0
      t.timestamps
    end
    add_index :entries, [:user_id, :recruit_id], unique: true
  end
end
