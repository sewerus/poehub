class Api::TagSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description
end