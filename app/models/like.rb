class Like < ApplicationRecord
  belongs_to :design
  belongs_to :user
  validates_uniqueness_of :design_id, scope: :user_id
end
