class Comment < ApplicationRecord


   belongs_to :customer
   belongs_to :recipe
   
   
   def get_image #画像が存在しない場合に表示する画像をActiveStorageに格納する
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
   end

end
