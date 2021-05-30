class HomeController < ApplicationController
	def index
		@courses = Course.where(enrollment_deadline: Date.today..)
		# @last_day_courses = Course.where(enrollment_deadline: Date.today)
	end
end
