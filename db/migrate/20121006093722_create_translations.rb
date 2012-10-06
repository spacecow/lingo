class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.integer :page_id

      t.timestamps
    end
  end
end
