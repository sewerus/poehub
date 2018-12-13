class Api::PoemsController < Api::ApiController

  def index
    poems = Poem.all
    render json: PoemSerializer.new(poems).serialized_json
  end
end