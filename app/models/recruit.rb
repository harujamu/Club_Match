class Recruit < ApplicationRecord
  enum age_group:{ unspecified: 0, junior_school_student: 1, secondary_school_student: 2, high_school_student: 3, college_student: 4, adult: 5 }
  enum recruit_status:{ recruiting: 0, having_candidates: 1, match: 2, decline: 3, done:4 }
  
  belongs_to :user
  belongs_to :recruit
  
end
