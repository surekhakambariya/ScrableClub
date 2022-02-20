# frozen_string_literal: true

# leader board controller
class LeaderBoardsController < ApplicationController
  def index
    participant_players_ids = Member.joins(:participants).group('members.id').having('count(participants.id) >= 10')
    @top_score_members = Member.where(id: participant_players_ids).includes(:participants).order('participants.score desc').limit(10)
  end
end
