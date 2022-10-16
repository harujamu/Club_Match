class Genre < ApplicationRecord
  has_many :users
  has_one_attached :genre_image
  
  validates :name, uniqueness: true, presence: true
end
