class Genre < ApplicationRecord

  has_many :ideas,dependent: :destroy

end
