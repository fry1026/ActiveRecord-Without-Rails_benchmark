class Author < ActiveRecord::Base
  has_many :books
  has_many :awards, through: :award_presentations
  def full_name
    "#{first_name} #{last_name}"
  end
end