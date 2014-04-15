class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :label
      t.boolean :sync

      t.timestamps
    end
  end
end
