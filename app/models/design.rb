class Design < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImgUploader # 画像アップロード
  self.inheritance_column = :_type_disabled
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  
  validates :image, presence: true
  validates :title, presence: true, uniqueness: true
  validates :user_id, presence: true
end
