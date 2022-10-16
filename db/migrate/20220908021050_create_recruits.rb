class CreateRecruits < ActiveRecord::Migration[6.1]
  def change
    create_table :recruits do |t|

      t.integer :user_id, null: false
      t.integer :site_id, null: false
      t.date :date, null: false
      t.integer :practice_type, null: false, default: 1
      t.boolean :liked_status, null: false, default: false
      t.integer :age_group, null: false, default: 1
      t.integer :recruit_status, null: false, default: 1
      t.boolean :open_status, null: false, default: true
      t.text :title, null: false
      t.text :detail, null: false
      t.timestamps
    end
  end
end
