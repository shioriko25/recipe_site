class CreateRecipes < ActiveRecord::Migration[6.1]
  def change
    create_table :recipes do |t|
      
       t.integer :customer_id, null: false
       t.string :name, null: false
       t.string :size, null: false
       t.string :quantity, null: false
       t.text :introduction
       t.text :point

      t.timestamps
    end
  end
end
