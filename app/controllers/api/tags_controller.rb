class Api::TagsController < Api::ApiController

  def index
    tags = Tag.all
    render json: TagSerializer.new(tags).serialized_json
  end

  def show
    tag = Tag.find(params[:id])
    poems = tag.poems
    render json: TagSerializer.new(tag).serialized_json + PoemSerializer.new(poems).serialized_json
  end
end