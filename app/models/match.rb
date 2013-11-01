class Match < ActiveRecord::Base
  belongs_to :manager, polymorphic: true
	belongs_to :contest
  belongs_to :referee
	has_many :player_matches
	has_many :players, through: :player_matches
	validates :manager, presence: true
end
