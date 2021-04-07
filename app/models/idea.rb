class Idea < ApplicationRecord

  belongs_to :member
  attachment :image
  has_many :idea_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :genre

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end

end
