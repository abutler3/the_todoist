class AddAdminToRole < ActiveRecord::Migration
  def change
    add_column :roles, :admin, :string
  end
end
