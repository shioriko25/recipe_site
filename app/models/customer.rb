class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :recipes, dependent: :destroy
    has_many :favorited_recipes, through: :favorites, source: :recipe#いいねランキング
    has_one_attached :image

    validates :name, presence: true
    validates :name_kana, presence: true
    validates :email, presence: true


  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "guestuser"
    end
  end


  def get_image #画像が存在しない場合に表示する画像をActiveStorageに格納する
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end


def self.looks(words)
    @customer = Customer.where("name LIKE ?", "%#{words}%")
end


end
