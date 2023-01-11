class RecipeTag < ApplicationRecord

  belongs_to :recipe_tag
  belongs_to :recipe

end
