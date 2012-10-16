class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :content
      t.integer :translation_id
      t.integer :user_id
      t.string :type

      t.timestamps
    end
  end
end
