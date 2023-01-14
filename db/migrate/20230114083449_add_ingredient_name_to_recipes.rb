class AddIngredientNameToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :ingredient_name, :text
  end
end
