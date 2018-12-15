class Api::UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  attribute :poems do |object|
    object.poems.map {|poem| poem.slice(:id, :title, :stone_date, :created_at)
                                 .merge(observing: poem.subscribes.count)
                                 .merge(first_version: poem.first_version)
                                 .merge(best_version: poem.best_version) }
  end
end