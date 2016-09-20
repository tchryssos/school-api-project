class Teacher < ApplicationRecord
  has_many :students, through: :school_classes
  has_many :school_classes
  validates :name, :subject, presence: true
end
