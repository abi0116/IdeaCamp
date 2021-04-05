class Idea < ApplicationRecord

  belongs_to :member
  attachment :image
  has_many :idea_comments,dependent: :destroy

end
