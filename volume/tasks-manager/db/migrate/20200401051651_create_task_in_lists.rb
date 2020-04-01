class CreateTaskInLists < ActiveRecord::Migration[6.0]
  def change
    create_table :task_in_lists do |t|
      t.boolean :checked
      t.belongs_to :task_list, foreign_key: true
      t.belongs_to :task, foreign_key: true
      t.timestamps
    end
  end
end
