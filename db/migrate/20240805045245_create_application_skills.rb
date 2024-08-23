class CreateApplicationSkills < ActiveRecord::Migration[7.1]
  def change
    create_table :application_skills do |t|
      t.references :application, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
