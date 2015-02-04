class AwardPresentation < ActiveRecord::Base
  belongs_to :award
  belongs_to :author
end