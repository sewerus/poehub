class PoemsController < ApplicationController
  before_action :reader_only, only: [:index, :favourites, :subscribed]
  before_action :writer_only, only: [:written]

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

end
