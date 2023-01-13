class Tag < ApplicationRecord
  
   has_many :recipe_tags
   has_many :recipes, through: :recipe_tags # タグは複数の投稿を持つ　それは、recipe_tagsを通じて参照できる.throughオプションは「〜を経由する」
  
end
