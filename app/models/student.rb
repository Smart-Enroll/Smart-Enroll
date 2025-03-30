class Student < ApplicationRecord
  # Validations
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  validates :credits_earned, numericality: { greater_than_or_equal_to: 0 }
  validates :major, presence: true # Optional validation

  # Associations
  has_many :user_schedules
  has_many :courses, through: :user_schedules

  # Secure password handling
  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end
end
