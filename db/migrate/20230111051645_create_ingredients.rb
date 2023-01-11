class CreateIngredients < ActiveRecord::Migration[6.1]
  def change
    create_table :ingredients do |t|
      
      t.integer :recipe_id, null: false
      t.string :name, null: false
      t.integer :name_number, null: false  #材料の順番を整理
      t.string :quantity #量
      t.string :unit  #数量単位

      t.timestamps
    end
  end
end
