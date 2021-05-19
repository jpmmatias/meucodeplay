class Teacher < ApplicationRecord
	has_one_attached :profile_picture

	validates :name, :email, presence: { message: 'não pode ficar em branco' }
	validates :email,
	          uniqueness: {
			case_sensitive: false,
			message: 'email já está em uso',
	          }
end
