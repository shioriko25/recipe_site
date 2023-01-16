class AddTagNameToTags < ActiveRecord::Migration[6.1]
  def change
    add_column :tags, :tag_name, :string
  end
end
