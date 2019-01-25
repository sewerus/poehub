class UsersController < ApplicationController
  before_action :admin_only, except: [:index, :show]
  before_action :set_user, only: [:show, :edit, :update, :block_user]

  def index
    @users = User.all
  end

  def show
  end

  def edit
  end

  def update
    if @user.update_attributes(roles_params)
      redirect_to users_path, :notice => "Użytkownik zaktualizowany."
    else
      redirect_to users_path, :alert => "Nie udało się zaktualizować użytkownika."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "Użytkownik usunięty."
  end

  def block_user
    @user.lock
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def roles_params
    params.require(:user).permit(role_ids: [])
  end
end
