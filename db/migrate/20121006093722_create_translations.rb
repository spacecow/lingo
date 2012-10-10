class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :page_id
      t.integer :x1
      t.integer :y1
      t.integer :x2
      t.integer :y2

      t.timestamps
    end
  end
end
