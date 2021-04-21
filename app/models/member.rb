class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :telephone_number, presence: true

  # def remember_me
    # true
  # end

  has_many :ideas,dependent: :destroy
  has_many :idea_comments,dependent: :destroy
  has_many :favorites,dependent: :destroy
  has_one :company,dependent: :destroy
  #通知機能のアソシエーション
  # has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  # has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

end
