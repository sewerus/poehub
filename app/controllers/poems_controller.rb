class PoemsController < ApplicationController
  before_action :reader_only, only: [:index, :favourites, :subscribed, :show]
  before_action :writer_only, only: [:new, :create, :written]
  before_action :set_poem, only: [:edit, :update, :destroy, :show, :toggle_subscribe]
  before_action :can_modify, only: [:edit, :update, :destroy]

  def index
    @poems = Poem.all
  end

  def favourites
    @poems = current_user.favourite_lines.map{|line| line.poem_version}
  end

  def subscribed
    @poems = current_user.subscribed_poems
  end

  def written
    @poems = current_user.poems
  end

  def new
    @poem = Poem.new
  end

  def edit
  end

  def show
  end

  def create
    @poem = Poem.new(poem_params)
    @poem.user = current_user
    if @poem.save_if_has_lines(params.require(:content).permit!.to_hash)
      redirect_to poem_path(@poem), notice: 'Właśnie dodałeś nowy wiersz!'
    else
      redirect_to written_path, notice: 'Nie udało się utworzyć nowego wiersza.'
    end
  end

  def update
    if @poem.update_attributes(poem_params)
      redirect_to poem_path(@poem), notice: 'Wiersz został zaktualizowany'
    else
      redirect_to poem_path(@poem), notice: 'Nie udało się zaktualizować wiersza.'
    end
  end

  def destroy
    @poem.destroy
  end

  def write_another_version
    @poem = Line.find(params[:id]).poem_version
  end

  def create_another_version
    @poem = Poem.find(params[:poem_id])
    if @poem.add_new_lines(params.require(:content).permit!.to_hash)
      redirect_to poem_path(@poem), notice: 'Właśnie dodałeś nową wersję wiersza!'
    else
      redirect_to written_path, notice: 'Nie udało się utworzyć nowego wiersza.'
    end
  end

  def toggle_subscribe
    @poem.toggle_subscribe(current_user)
    redirect_to poems_path
  end

  def toggle_like
    Line.find(params[:id]).toggle_like(current_user)
    redirect_to poems_path
  end

  def best_poems
  end

  private
  def set_poem
    @poem = Poem.find(params[:id])
  end

  def poem_params
    params.require(:poem).permit(:title, :stone_date, tag_ids: [])
  end

  def can_modify
    unless @poem.can_modify?(current_user)
      redirect_to(root_path, :alert => "Brak dostępu, tylko dla administratorów!")
    end
  end
end
