class UpdatePageContentsAndContactsTable < ActiveRecord::Migration[7.1]
  def change
    change_column :page_contents, :mission, :text
    change_column :page_contents, :vision, :text

    # Add a new column 'contact_header'
    add_column :page_contents, :contact_header, :string

    # Remove the 'contact' column if it exists
    remove_column :contacts, :heading, :string
  end
end
