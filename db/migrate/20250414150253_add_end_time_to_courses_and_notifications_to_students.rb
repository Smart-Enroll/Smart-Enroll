class AddEndTimeToCoursesAndNotificationsToStudents < ActiveRecord::Migration[8.0]
  def change
    add_column :students, :end_time, :time
    add_column :students, :notifications, :integer
    change_column :courses, :class_time, :time
  end
end
