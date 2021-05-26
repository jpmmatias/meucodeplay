class Course < ApplicationRecord
	before_create :set_default_banner
	belongs_to :teacher
	has_many :lectures, dependent: :destroy
	has_one_attached :banner

	validates :name, :code, :price, :teacher_id, presence: true
	validates :code, uniqueness: true

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
