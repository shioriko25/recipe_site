class AddProcessToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :process, :text
  end
end
