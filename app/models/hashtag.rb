class Hashtag < ApplicationRecord
  has_many :tweets, dependent: :destroy
end
