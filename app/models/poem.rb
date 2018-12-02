class Poem < ApplicationRecord
  belongs_to :user
  has_one :first_line, class_name: 'Line', foreign_key: 'first_line_id', primary_key: 'id'
  has_many :subscribes
  has_and_belongs_to_many :tags, join_table: 'poems_tags'
end
