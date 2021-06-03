class Comment < ApplicationRecord
	belongs_to :lecture
	belongs_to :student

	validates :content, presence: true
end
