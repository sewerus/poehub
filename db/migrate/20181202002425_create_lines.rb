class CreateLines < ActiveRecord::Migration[5.1]
  def change
    create_table :lines do |t|
      t.belongs_to :user
      t.string :content
      t.integer :previous_line_id
      t.timestamps
    end
  end
end
