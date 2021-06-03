class Enrollment < ApplicationRecord
	belongs_to :course
	belongs_to :student
	validates :course, uniqueness: { scope: :student }
end
