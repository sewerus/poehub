class Api::PoemSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :stone_date, :user, :tags, :all_versions
end