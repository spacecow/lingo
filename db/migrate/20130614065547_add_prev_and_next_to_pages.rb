class AddPrevAndNextToPages < ActiveRecord::Migration
  def change
    add_column :pages, :next_id, :integer
    add_column :pages, :prev_id, :integer
  end
end
