class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :no
      t.integer :project_id

      t.timestamps
    end
  end
end
