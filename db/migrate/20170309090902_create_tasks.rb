class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.string :due_date
      t.boolean :completed, null: false, default: false
      t.integer  :user_id
      t.timestamps
    end
  end
end
