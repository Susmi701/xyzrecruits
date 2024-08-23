class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :description
      t.boolean :status, default: true
      t.references :category, null: false, foreign_key: true
      t.integer :experience_required
      t.string :location
      t.string :educational_qualification
      t.integer :job_type
      t.datetime :closing_date

      t.timestamps
    end
  end
end
