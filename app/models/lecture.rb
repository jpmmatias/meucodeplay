class Lecture < ApplicationRecord
	belongs_to :course
	has_many :comments, dependent: :destroy
	validates :name, :content, :time, presence: true
end
