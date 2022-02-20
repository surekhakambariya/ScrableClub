# frozen_string_literal: true

# Participant model
class Participant < ApplicationRecord
  # enum
  enum status: %i[winner loser]

  # Relationships
  belongs_to :member
  belongs_to :game

  # Validations
  validates :game_id, uniqueness: { scope: :member_id }
  validates :score, presence: true
end
