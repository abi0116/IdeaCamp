class Idea < ApplicationRecord
  belongs_to :member
  attachment :image
end
