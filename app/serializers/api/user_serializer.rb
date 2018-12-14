class Api::UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :poems
end