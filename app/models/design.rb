class Design < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImgUploader # 画像アップロード
  self.inheritance_column = :_type_disabled
  
  validates :title, presence: true
  validates :user_id, presence: true
end
