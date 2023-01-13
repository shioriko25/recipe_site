class Recipe < ApplicationRecord

  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_many :ingredients, dependent: :destroy
  has_many :steps, dependent: :destroy
  has_one_attached :image
  has_many :tags,through: :recipe_tags #throughオプションは「〜を経由する」


def get_image #画像が存在しない場合に表示する画像をActiveStorageに格納する
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
end


end
