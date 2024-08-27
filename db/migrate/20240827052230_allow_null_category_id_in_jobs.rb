class AllowNullCategoryIdInJobs < ActiveRecord::Migration[7.1]
  def change
    change_column_null :jobs, :category_id, true
  end
end
