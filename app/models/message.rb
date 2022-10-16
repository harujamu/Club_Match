class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room
  has_many :notifies, dependent: :destroy
  
  validates :message, presence: true,
end
