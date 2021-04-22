class Genre < ApplicationRecord

  has_many :ideas,dependent: :destroy

  validates :name, presence: true
  validates :genre_image, presence: true

  attachment :genre_image

end
