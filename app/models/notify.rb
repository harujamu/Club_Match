class Notify < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :recruit, optional: true
  belongs_to :like, optional: true
  belongs_to :follow, optional: true
  belongs_to :entry, optional: true
  belongs_to :message, optional: true
  belongs_to :notifier, class_name: 'User', foreign_key: 'notifier_id', optional: true
  belongs_to :checker, class_name: 'User', foreign_key: 'checker_id', optional: true
  

  validates :notifier_id, presence: true
  validates :checker_id, presence: true
end
