class AddPosToPages < ActiveRecord::Migration
  def change
    add_column :pages, :pos, :integer
  end
end
