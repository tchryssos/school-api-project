class Student < ApplicationRecord
  has_many :teachers, through: :school_classes
  has_many :school_classes
  validates :name, :grade, presence: true
end
