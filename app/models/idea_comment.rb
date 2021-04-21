class IdeaComment < ApplicationRecord

  belongs_to :member
  belongs_to :idea
  #通知機能のアソシエーション
  # has_many :notifications, dependent: :destroy

end
