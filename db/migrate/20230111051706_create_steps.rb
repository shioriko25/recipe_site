class CreateSteps < ActiveRecord::Migration[6.1]
  def change
    create_table :steps do |t|
      
      t.integer :recipe_id, null: false
      t.integer :process_number, null: false  #作り方順
      t.string :process, null: false  #作り方
      
      t.timestamps
    end
  end
end
