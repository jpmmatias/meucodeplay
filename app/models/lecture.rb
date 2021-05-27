class Lecture < ApplicationRecord
	belongs_to :course
	extend FriendlyId
	friendly_id :name, use: :slugged
	has_many :comments, dependent: :destroy
	validates :name, :content, :time, presence: true

	def should_generate_new_friendly_id?
		name_changed?
	end
end
