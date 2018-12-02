class Poem < ApplicationRecord
  belongs_to :user
  has_one :first_line, class_name: 'Line', foreign_key: 'first_line_id', primary_key: 'id'
end
