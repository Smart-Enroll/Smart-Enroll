class Course < ApplicationRecord
    self.primary_key = "CRN"  # Explicitly set CRN as primary key
  
    # Validations
    validates :CRN, presence: true, uniqueness: true, numericality: { only_integer: true }
    validates :class_name, presence: true
    validates :professor, presence: true
    validates :term, presence: true
    validates :credits, numericality: { greater_than: 0 }
    validates :class_time, presence: true
  
    # Associations
    has_many :user_schedules
    has_many :students, through: :user_schedules
  
    has_many :enrollments
    has_many :students, through: :enrollments
  
    has_many :prerequisites, class_name: "ClassPrerequisite", foreign_key: "course_name"
    has_many :required_courses, through: :prerequisites, source: :prerequisite
  
    # Instance Methods
    def full_course_name
      "#{class_name} (#{CRN}) - #{term}"
    end
  end
  