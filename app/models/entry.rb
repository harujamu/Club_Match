class Entry < ApplicationRecord
  enum entry_status: { entered: 1, match: 2, match_rejected: 3, done: 4 }
  
  belongs_to :user
  belongs_to :recruit
  has_many :notifies, dependent: :destroy
  
end
