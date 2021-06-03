class LecturesController < ApplicationController
	before_action :get_lecture, only: %i[show]
	before_action :get_course, only: %i[show]
	before_action :student_has_enrollment, only: %i[show]

	def show
		@comments = Comment.all
		@comment = Comment.new
	end

	private

	def student_has_enrollment
		unless current_student.courses.include?(@lecture.course)
			redirect_to @lecture.course
		end
	end

	def get_lecture
		@lecture = Lecture.friendly.find(params[:id])
	end

	def get_course
		@course = Course.friendly.find(params[:course_id])
	end

	def lecture_params
		params.require(:lecture).permit(:name, :time, :description, :content)
	end
end
