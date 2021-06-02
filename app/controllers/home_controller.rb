class HomeController < ApplicationController
	layout :verify_layout

	def index
		@courses = Course.available
	end

	private

	def verify_layout
		return 'admin' if user_signed_in?

		'application'
	end
end
