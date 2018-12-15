class Api::TagSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :description

  attribute :poems do |object|
      object.poems.map {|poem| poem.slice(:id, :title, :stone_date, :created_at)
                                   .merge(observing: poem.subscribes.count)
                                   .merge(user: {id: poem.user.id, name: poem.user.name})
                                   .merge(first_version: poem.first_version)
                                   .merge(best_version: poem.best_version) }
  end

end