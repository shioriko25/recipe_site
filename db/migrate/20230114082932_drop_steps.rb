class DropSteps < ActiveRecord::Migration[6.1]
  def change
     drop_table :steps
  end
end
