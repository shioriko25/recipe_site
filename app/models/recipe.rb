class Recipe < ApplicationRecord

  belongs_to :customer
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :recipe_tags, dependent: :destroy
  has_one_attached :image
  has_many :tags, through: :recipe_tags, dependent: :destroy  #throughオプションは「〜を経由する」
   has_many :favorited_customers, through: :favorites, source: :customer#いいねランキング


def get_image #画像が存在しない場合に表示する画像をActiveStorageに格納する
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
end

def save_tag(sent_tags) #createアクションで記述したsave_tagインスタンスメソッドの中身を定義
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil? #タグの名前を配列pluck(:tag_name)として全て取得します。
    old_tags = current_tags  #存在するタグから、送信されてきたタグを除いたタグをold_tagsとします
    new_tags = sent_tags  #送信されてきたタグから、現在存在するタグを除いたタグをnew_tagsとする

    old_tags.each do |old| #古いタグを削除します。
      self.recipe_tags.destroy_all
    end
    new_tags.each do |new| #新しいタグの保存
      tag = Tag.find_or_create_by!(tag_name: new)
      new_recipe_tag = self.recipe_tags.new(tag_id: tag.id)
      self.recipe_tags << new_recipe_tag
    end
end

def self.looks(words)
    @recipe = Recipe.where("name LIKE ?", "%#{words}%")
end


def favorited_by?(customer) #ユーザidがFavoritesテーブル内に存在（exists?）するかどうかを調べます。
    favorites.exists?(customer_id: customer.id)
end

end
