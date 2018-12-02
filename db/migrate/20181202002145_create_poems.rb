class CreatePoems < ActiveRecord::Migration[5.1]
  def change
    create_table :poems do |t|
      t.integer :first_line_id
      t.belongs_to :user
      t.datetime :stone_date
      t.timestamps
    end
  end
end
