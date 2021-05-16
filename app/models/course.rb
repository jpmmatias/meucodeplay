class Course < ApplicationRecord
	validates :name,
	          :code,
	          :description,
	          :price,
	          presence: {
			message: 'não pode ficar em branco',
	          }
	validates :code,
	          uniqueness: {
			case_sensitive: false,
			message: 'já está em uso',
	          }
end
