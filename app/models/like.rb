class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recruit
  has_many :notifies
  
  def liked_by?(user)
    likes.exists?(user_id:user.id)
  end
  
end
