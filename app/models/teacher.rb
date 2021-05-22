class Teacher < ApplicationRecord
	has_many :courses, dependent: :destroy
	has_one_attached :profile_picture

	validates :name, :email, presence: true
	validates :email,
	          uniqueness: {
			case_sensitive: false,
			message: 'já está em uso',
	          }

	def display_name_and_email
		"#{name} - #{email}"
	end
end
