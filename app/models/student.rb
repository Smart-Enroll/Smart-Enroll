class Student < ApplicationRecord
    # Validations
    validates :email, presence: true, uniqueness: true
    validates :name, presence: true
    validates :credits_earned, numericality: { greater_than_or_equal_to: 0 }

    # Patrick Addition
    # Will make it so its easy to retrieve every course each student is enrolled in
    has_many :user_schedules
    has_many :courses, through: :user_schedules
    # Secure password handling
    has_secure_password

    # Associations (if applicable, e.g., if a student belongs to a course)
    # belongs_to :course # Example if you have a course model

    def full_name
      "#{first_name} #{last_name}"
    end
end
