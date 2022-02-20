# frozen_string_literal: true

# games controller
class GamesController < ApplicationController
  before_action :fetch_game, only: :show

  def index
    @games = Game.all
  end

  def new
    @game = Game.new
    2.times { @game.participants.build }
  end

  def create
    @game = Game.new(game_params)
    if @game.participants[0][:member_id].eql?(@game.participants[1][:member_id])
      redirect_to :new, notice: 'Same member not allow.'
    else
      if @game.save
        @game.change_player_status
        redirect_to games_path
      else
        render :new
      end
    end
  end

  def show; end

  private

  # fetch game data
  def fetch_game
    @game = Game.friendly.find(params[:id])
  end

  # strong params permit
  def game_params
    params.require(:game).permit(:title, :description, participants_attributes: %i[member_id score])
  end
end
