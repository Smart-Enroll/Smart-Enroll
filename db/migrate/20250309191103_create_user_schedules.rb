class CreateUserSchedules < ActiveRecord::Migration[8.0]
  def change
    create_table :user_schedules do |t|
      t.references :student, null: false, foreign_key: true
      t.references :course, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end
