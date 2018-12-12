class PoemsController < ApplicationController
  before_action :reader_only, only: [:index, :favourites, :subscribed]
  before_action :writer_only, only: [:written]
  before_action :set_poem, only: [:create, :update, :destroy]

  def index
    @poems = Poem.all
  end

  def favourites
    @poems = current_user.favourites_lines.map{|line| line.poem}
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

  def create
    @poem = Poem.new(poem_params)
    if @poem.save
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

  private
  def set_poem
    @poem = Poem.find(params[:id])
  end

  def poem_params
    params.require(:poem).permit(:title, :stone_date)
  end

end
