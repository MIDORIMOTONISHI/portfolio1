class Design < ApplicationRecord
  belongs_to :user
  has_many :orders, dependent: :destroy
  mount_uploader :image, ImgUploader # 画像アップロード
  self.inheritance_column = :_type_disabled
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  
  validates :image, presence: true
  validates :title, presence: true, uniqueness: true
  validates :user_id, presence: true
  
  def self.search(search)
    if search
      Design.where(['title LIKE ?', "%#{search}%"])
      
    else
      Design.all
    end
  end
end
