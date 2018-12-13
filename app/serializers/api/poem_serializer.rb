class PoemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :stone_date, :user_id
  #has_many :lines
end