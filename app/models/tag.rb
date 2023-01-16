class Tag < ApplicationRecord
  
   has_many :recipe_tags, dependent: :destroy
   has_many :recipes, through: :recipe_tags, dependent: :destroy
   # タグは複数の投稿を持つ　それは、recipe_tagsを通じて参照できる.throughオプションは「〜を経由する」
  
end
