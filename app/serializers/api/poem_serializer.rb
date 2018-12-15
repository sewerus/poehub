class Api::PoemSerializer
  include ActiveModel::Serialization
  include FastJsonapi::ObjectSerializer

  attributes :title, :stone_date, :all_versions

  attribute :tags do |object|
    object.tags.each do |tag|
      {id: tag.id, title: tag.title}
    end
  end

  attribute :user do |object|
    {id: object.user.id, name: object.user.name}
  end

  attribute :subscriptions do |object|
    object.subscribes.count
  end
end