# frozen_string_literal: true

# Member helper
module MembersHelper
  def avrage_score(participants)
    participants.average(:score).round(2)
  end

  def win_games_count(participants)
    participants.where(status: 'winner').count
  end

  def los_games_count(participants)
    participants.where(status: 'loser').count
  end
end
