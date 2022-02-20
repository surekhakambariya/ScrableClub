# frozen_string_literal: true

# Member model
class Member < ApplicationRecord
  # for slug
  extend FriendlyId
  friendly_id :full_name, use: :slugged

  # Relationships
  has_many :participants, dependent: :destroy

  # Validations
  validates :full_name, :email, presence: true
  validates :mobile_number, presence: true, numericality: true, length: { minimum: 10, maximum: 15 }

  # Participants counts
  def number_of_games
    participants.count
  end

  # this method return custom hash with rank details
  def rank_details
    participant = participants.order(score: :desc).first
    return nil unless participant.present?

    game = participant.game
    another_palyer = game.participants.where.not(member_id: participant.member_id).last&.member&.full_name
    { highest_score: participant.score, game_name: game.title, game_time: game.created_at, another_player: another_palyer }
  end
end
