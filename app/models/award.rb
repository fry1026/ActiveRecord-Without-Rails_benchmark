class Award < ActiveRecord::Base
  has_many :authors, through: :award_presentations
end