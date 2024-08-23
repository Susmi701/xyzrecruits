class CreatePageContents < ActiveRecord::Migration[7.1]
  def change
    create_table :page_contents do |t|
      t.string :key
      t.text :content

      t.timestamps
    end
  end
end
