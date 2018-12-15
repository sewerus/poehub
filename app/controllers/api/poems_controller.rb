class Api::PoemsController < Api::ApiController

  def index
    poems = Poem.all
    render json: Api::PoemSerializer.new(poems).serialized_json
  end

  def show
    poem = Poem.find(params[:id])
    render json: Api::PoemSerializer.new(poem).serialized_json
  end
end