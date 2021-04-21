class Idea < ApplicationRecord

  belongs_to :member
  attachment :image
  acts_as_taggable
  has_many :idea_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  belongs_to :genre
  #通知機能のアソシエーション
  # has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :caption, presence: true
  validates :genre_id, presence: true
  validates :image, presence: true

  enum adopted_status: {
      "選考中(未採用)": 0,#選考中(未採用)
      "採用済み(企画中)": 1,#採用済み(企画中)
      "採用済み(企画停止中)": 10,#採用済み(企画停止中)
      "採用済み(完了済み)": 100#採用済み(完了済み)
  }

  def favorited_by?(member)
    favorites.where(member_id: member.id).exists?
  end

  def create_notification_like!(current_member)
    # すでに「いいね」されているか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and idea_id = ? and action = ? ", current_member.id, member_id, id, 'favorite'])
    # いいねされていない場合のみ、通知レコードを作成,いいね連打での通知をどうするかの処理
    if temp.blank?
      notification = current_member.active_notifications.new(
        idea_id: id,
        visited_id: member_id,
        action: 'favorite'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_member, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:member_id).where(idea_id: id).where.not(member_id: current_member.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_member, comment_id, temp_id['member_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_member, comment_id, member_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_member, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      idea_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
