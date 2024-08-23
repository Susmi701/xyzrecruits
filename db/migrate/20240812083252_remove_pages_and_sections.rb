class RemovePagesAndSections < ActiveRecord::Migration[7.1]
  def change
    
    drop_table :sections, if_exists: true
    drop_table :pages, if_exists: true
  end
end
