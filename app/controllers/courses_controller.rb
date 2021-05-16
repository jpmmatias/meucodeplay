class CoursesController < ApplicationController
	before_action :set_course, only: %i[show]
	before_action :course_params, only: %i[create]
	def index
		@courses = Course.all
	end
	def show
		@course = Course.find(params[:id])
	end
	def new
		@course = Course.new
	end

	def create
		if @course.save
			redirect_to @course
		else
			render :new
		end
	end

	private

	def set_course
		@course = Course.find(params[:id])
	end

	def course_params
		@course =
			Course.new(
				params
					.require(:course)
					.permit(:name, :description, :code, :price, :enrollment_deadline),
			)
	end
end
