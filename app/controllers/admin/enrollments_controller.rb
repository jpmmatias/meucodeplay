class Admin::EnrollmentsController < Admin::AdminController
	before_action :authenticate_user!
	def index
		@enrollments = Enrollment.all
	end
end
