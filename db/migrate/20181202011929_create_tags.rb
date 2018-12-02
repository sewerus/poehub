class CreateTags < ActiveRecord::Migration[5.1]
  def change
    create_table :tags do |t|
      t.string :title
      t.text :description
      t.timestamps
    end

    create_table :poems_tags do |t|
      t.belongs_to :tag
      t.belongs_to :poem
    end
  end
end
