class CreateRecruits < ActiveRecord::Migration[6.1]
  def change
    create_table :recruits do |t|

      t.integer :user_id, null: false
      t.integer :site_id, null: false
      t.date :date, null: false
      t.boolean :practice_type, null: false, default: true
      t.integer :age_group, null: false
      t.integer :recruit_status, null: false, default: 0
      t.boolean :open_status, null: false, default: true
      t.text :title, null: false
      t.text :detail, null: false
      t.timestamps
    end
  end
end
