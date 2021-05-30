class User < ApplicationRecord
	validates :name, presence: true
	has_many :enrollments
	has_many :comments
	has_many :courses, through: :enrollments

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
	devise :database_authenticatable,
	       :registerable,
	       :recoverable,
	       :rememberable,
	       :validatable
end
