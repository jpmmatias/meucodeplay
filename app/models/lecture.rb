class Lecture < ApplicationRecord
	belongs_to :course
	validates :name, :content, :time, presence: true
end
