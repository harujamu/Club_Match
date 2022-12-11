# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :user
  belongs_to :follower, class_name: "User", foreign_key: "follower_id", optional: true
  has_many :notifies, dependent: :destroy

  validates :follower_id, presence: true
end
