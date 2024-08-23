class UpdatePageContents < ActiveRecord::Migration[7.1]
  def change
    change_table :page_contents do |t|
      t.remove :key, :content
      t.string :home_header
      t.text :mission
      t.text :vision
      t.string :about_header
      t.text :about_us
      t.text :history
      t.string :ceo
      t.string :contact_header

    end
  end
end
