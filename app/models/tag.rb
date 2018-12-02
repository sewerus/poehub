class Tag < ApplicationRecord
  has_and_belongs_to_many :poems, join_table: 'poems_tags'
end
