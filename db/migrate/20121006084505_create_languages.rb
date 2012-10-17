class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.integer :translation_id
      t.string :type

      t.timestamps
    end
  end
end
