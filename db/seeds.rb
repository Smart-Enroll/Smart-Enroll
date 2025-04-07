# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)


# Admin.create!(
#   name: "Super Admin2",
#   email: "admin2@example.com",
#   password: "securepassword2",
#   password_confirmation: "securepassword2",
#   role: "superadmin"
# )
# Student.create!(email: "student42@example.com",
#  name: "Marin Doe",
#  password_digest: "hashedpassword321",
#  credits_earned: 20)

#  Course.create!(
#   CRN: 102,
#   class_name: "Operating Systems",
#   professor: "Dr. Small",
#   term: "Fall 2023",
#   credits: 3,
#   class_time: "10:00"
# )


# Create an Admin if it doesn't already exist
Admin.find_or_create_by!(
  email: "admin@example.com"
) do |admin|
  admin.name = "Super Admin"
  admin.password = "securepassword"
  admin.password_confirmation = "securepassword"
  admin.role = "superadmin"
end

# Create a Student if it doesn't already exist
Student.find_or_create_by!(
  email: "student42@example.com"
) do |student|
  student.name = "Marin Doe"
  student.password_digest = "hashedpassword321"
  student.credits_earned = 20
end

# Create a Course if it doesn't already exist
Course.find_or_create_by!(
  CRN: 102
) do |course|
  course.class_name = "Operating Systems"
  course.professor = "Dr. Small"
  course.term = "Fall 2023"
  course.credits = 3
  course.class_time = "10:00"
end
