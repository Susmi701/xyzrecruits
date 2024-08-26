class UpdatePageContentsAndContactsTable < ActiveRecord::Migration[7.1]
  def change
    change_column :page_contents, :mission, :text
    change_column :page_contents, :vision, :text


    remove_column :contacts, :heading, :string
  end
end
