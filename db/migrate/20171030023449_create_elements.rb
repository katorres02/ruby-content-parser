class CreateElements < ActiveRecord::Migration[5.0]
  def change
    create_table :elements do |t|
      t.references :page, foreign_key: true
      t.string :tag
      t.text :html
      t.text :content
      t.string :href

      t.timestamps
    end
  end
end
