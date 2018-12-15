class Api::UsersController < Api::ApiController

  def index
    users = User.all
    render json: Api::UserSerializer.new(users).serialized_json
  end

  def show
    user = User.find(params[:id])
    render json: Api::UserSerializer.new(user).serialized_json
  end
end