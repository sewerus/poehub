class CreateSubscribes < ActiveRecord::Migration[5.1]
  def change
    create_table :subscribes do |t|
      t.belongs_to :user
      t.belongs_to :poem
      t.timestamps
    end
  end
end
