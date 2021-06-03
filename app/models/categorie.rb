class Categorie < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

	validates :name, presence: true, uniqueness: { case_sensitive: false }

	has_many :courses
end
