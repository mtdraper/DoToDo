class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :due_date
      t.datetime :completion_date
      t.string :label
      t.boolean :sync
      t.integer :category_id

      t.timestamps
    end
  end
end
