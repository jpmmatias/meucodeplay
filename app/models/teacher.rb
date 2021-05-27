class Teacher < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: :slugged

	has_many :courses, dependent: :destroy
	has_one_attached :profile_picture

	validates :name, :email, presence: true
	validates :email,
	          uniqueness: {
			case_sensitive: false,
			message: 'já está em uso',
	          }

	def should_generate_new_friendly_id?
		name_changed?
	end

	def display_name_and_email
		"#{name} - #{email}"
	end
end
