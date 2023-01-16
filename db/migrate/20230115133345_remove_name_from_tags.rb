class RemoveNameFromTags < ActiveRecord::Migration[6.1]
  def change
    remove_column :tags, :name, :string
  end
end
