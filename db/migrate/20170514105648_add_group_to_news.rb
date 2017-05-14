class AddGroupToNews < ActiveRecord::Migration
  def change
    add_column :news, :group_id, :integer
  end
end
