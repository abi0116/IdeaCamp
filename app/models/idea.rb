class Idea < ApplicationRecord

  belongs_to :member
  attachment :image
  acts_as_taggable
  has_many :idea_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :genre

  # validates :title, presence: true
  # validates :caption, presence: true
  # validates :genre_id, presence: true
  # validates :image_id, presence: true

  enum adopted_status: {
      "選考中(未採用)": 0,#選考中(未採用)
      "採用済み(企画中)": 1,#採用済み(企画中)
      "採用済み(企画停止中)": 10,#採用済み(企画停止中)
      "採用済み(完了済み)": 100#採用済み(完了済み)
  }

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end

end
