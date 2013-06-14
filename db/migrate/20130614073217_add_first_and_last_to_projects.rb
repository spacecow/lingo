class AddFirstAndLastToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :first_id, :integer
    add_column :projects, :last_id, :integer
  end
end
