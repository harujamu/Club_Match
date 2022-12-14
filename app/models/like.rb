# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :recruit
  has_many :notifies, dependent: :destroy
end
