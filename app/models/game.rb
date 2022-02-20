# frozen_string_literal: true

# Game model
class Game < ApplicationRecord
  # for slug
  extend FriendlyId
  friendly_id :title, use: :slugged

  # Relationships
  has_many :participants, dependent: :destroy

  # nested attributes for add participants player
  accepts_nested_attributes_for :participants

  def change_player_status
    game_participants = participants.order(score: :desc).ids
    if game_participants.count <= 1
      update(status: 'winner')
    else
      Participant.where(id: game_participants.shift).update(status: 'winner')
      Participant.where(id: game_participants).update(status: 'loser')
    end
  end
end
