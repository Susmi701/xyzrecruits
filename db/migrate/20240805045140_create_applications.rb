class CreateApplications < ActiveRecord::Migration[7.1]
  def change
    create_table :applications do |t|
      t.references :job, null: false, foreign_key: true
      t.string :name
      t.string :email
      t.integer :experience
      t.float :fit_score
      t.integer :status,default: 0

      t.timestamps
    end
  end
end
