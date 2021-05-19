class Course < ApplicationRecord
	before_create :set_default_banner

	has_one_attached :banner

	validates :name,
	          :code,
	          :price,
	          presence: {
			message: 'não pode ficar em branco',
	          }
	validates :code,
	          uniqueness: {
			case_sensitive: false,
			message: 'já está em uso',
	          }

	private

	def set_default_banner
		if self.banner.present?
			return
		else
			self.banner.attach(
				io: File.open(Rails.root.join('spec', 'fixtures', 'course.jpg')),
				filename: 'course.jpg',
				content_type: 'image/jpg',
			)
		end
	end
end
