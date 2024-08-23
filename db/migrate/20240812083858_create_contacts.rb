class CreateContacts < ActiveRecord::Migration[7.1]
  def change
    create_table :contacts do |t|
      t.string :heading
      t.string :address
      t.string :phone
      t.string :email
      t.string :website

      t.timestamps
    end
  end
end
