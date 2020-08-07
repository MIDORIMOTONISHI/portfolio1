class Order < ApplicationRecord
  belongs_to :design
  
  validates :size, presence: true
  validates :hw, presence: true
  validates :paper, presence: true
  validates :number, presence: true
  validates :delivery_date, presence: true
  validates :note, length: { maximum: 100 }
end
