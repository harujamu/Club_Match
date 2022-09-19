class Entry < ApplicationRecord
  enum entry_status: { entered: 0, match: 1, match_rejected: 2, done: 3 }
  
  belongs_to :user
  belongs_to :recruit
  has_many :notifies, dependent: :destroy
end
