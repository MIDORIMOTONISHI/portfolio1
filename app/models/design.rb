class Design < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImgUploader # 画像アップロード
  self.inheritance_column = :_type_disabled
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  validates :image, presence: true
  validates :title, presence: true, uniqueness: true
  validates :user_id, presence: true
  validates :size, presence: true
  validates :hw, presence: true
  validates :paper, presence: true
  validates :number, presence: true
  validates :delivery_date, presence: true
  validates :note, length: { maximum: 100 }
end
