class Entry < ApplicationRecord
  enum entry_status: { entered: 1, match: 2, match_rejected: 3, done: 4 }

  after_find do |entry|
    # 応募ステータスが応募済になったら、募集ステータスも候補者ありに更新
    if entry.entry_status == "entered"
      entry.recruit.update(recruit_status: "having_candidates")
    end
  end
  
  belongs_to :user
  belongs_to :recruit
  has_many :notifies, dependent: :destroy

end
