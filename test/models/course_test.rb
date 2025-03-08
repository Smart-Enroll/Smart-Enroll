# # test/models/course_test.rb
# require "test_helper"

# class CourseTest < ActiveSupport::TestCase
#   #Test if a Course is valid with all required attributes
#   test "should be valid with valid attributes" do
#     course = Course.new(
#       CRN: 102,
#       class_name: "Operating Systems",
#       professor: "Dr. Small",
#       term: "Fall 2023",
#       credits: 3,
#       class_time: "10:00"
#     )
#     assert course.valid?, "Course should be valid with all attributes"
#   end

#   # Test if a Course is invalid without a CRN
#   test "should be invalid without a CRN" do
#     course = Course.new(
#       CRN: nil,
#       class_name: "Operating Systems",
#       professor: "Dr. Small",
#       term: "Fall 2023",
#       credits: 3,
#       class_time: "10:00"
#     )
#     assert_not course.valid?, "Course should be invalid without a CRN"
#   end

#   # Test if a Course is invalid without a class_name
#   test "should be invalid without a class_name" do
#     course = Course.new(
#       CRN: 102,
#       class_name: nil,
#       professor: "Dr. Small",
#       term: "Fall 2023",
#       credits: 3,
#       class_time: "10:00"
#     )
#     assert_not course.valid?, "Course should be invalid without a class_name"
#   end

#   # Test if a Course is invalid without a professor
#   test "should be invalid without a professor" do
#     course = Course.new(
#       CRN: 102,
#       class_name: "Operating Systems",
#       professor: nil,
#       term: "Fall 2023",
#       credits: 3,
#       class_time: "10:00"
#     )
#     assert_not course.valid?, "Course should be invalid without a professor"
#   end

#   # Test if a Course is invalid without a term
#   test "should be invalid without a term" do
#     course = Course.new(
#       CRN: 102,
#       class_name: "Operating Systems",
#       professor: "Dr. Small",
#       term: nil,
#       credits: 3,
#       class_time: "10:00"
#     )
#     assert_not course.valid?, "Course should be invalid without a term"
#   end

#   # Test if a Course is invalid without credits
#   test "should be invalid without credits" do
#     course = Course.new(
#       CRN: 102,
#       class_name: "Operating Systems",
#       professor: "Dr. Small",
#       term: "Fall 2023",
#       credits: nil,
#       class_time: "10:00"
#     )
#     assert_not course.valid?, "Course should be invalid without credits"
#   end

#   # Test if a Course is invalid without class_time
#   test "should be invalid without class_time" do
#     course = Course.new(
#       CRN: 102,
#       class_name: "Operating Systems",
#       professor: "Dr. Small",
#       term: "Fall 2023",
#       credits: 3,
#       class_time: nil
#     )
#     assert_not course.valid?, "Course should be invalid without class_time"
#   end

#   # Test that CRN must be unique
#   test "should be invalid if CRN is not unique" do
#     Course.create!(
#       CRN: 102,
#       class_name: "Operating Systems",
#       professor: "Dr. Small",
#       term: "Fall 2023",
#       credits: 3,
#       class_time: "10:00"
#     )

#     course = Course.new(
#       CRN: 102, # Same CRN as the existing record
#       class_name: "Data Structures",
#       professor: "Dr. Jane",
#       term: "Spring 2024",
#       credits: 3,
#       class_time: "11:00"
#     )

#     assert_not course.valid?, "Course should be invalid with a duplicate CRN"
#   end
# end


