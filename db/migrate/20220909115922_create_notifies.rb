class CreateNotifies < ActiveRecord::Migration[6.1]
  def change
    create_table :notifies do |t|

      t.integer :recruit_id
      t.integer :entry_id
      t.integer :like_id
      t.integer :message_id
      t.integer :notifier_id, null: false
      t.integer :checker_id, null: false
      t.boolean :checked_status, null: false, default: false
      t.timestamps
    end
  end
end
