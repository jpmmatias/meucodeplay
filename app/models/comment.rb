class Comment < ApplicationRecord
	belongs_to :lecture

	validates :content, presence: true
end
