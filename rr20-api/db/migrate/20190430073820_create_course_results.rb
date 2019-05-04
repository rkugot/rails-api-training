class CreateCourseResults < ActiveRecord::Migration[5.1]
  def change
    create_table :course_results do |t|
      t.decimal :usd, precision: 7, scale: 4
      t.decimal :eur, precision: 7, scale: 4
      t.decimal :rur, precision: 7, scale: 4
      t.datetime :created_at
    end
  end
end
