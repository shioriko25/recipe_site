class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :recipes, dependent: :destroy
    
    has_one_attached :image
    
      
  def get_image #画像が存在しない場合に表示する画像をActiveStorageに格納する
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

    
end
