class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|

      t.integer :user_id, null: false
      t.integer :recruit_id, null: false
      t.integer :entry_status, null: false, default: 
      t.timestamps
    end
  end
end
