class CoursesController < ApplicationController
	before_action :set_course, only: %i[show edit update destroy enroll]
	def index
		@courses = Course.all
	end
	def show
		@lectures = Lecture.where(course_id: @course.id)
	end

	def enroll
		current_student.enrollments.create(course: @course, price: @course.price)

		redirect_to my_courses_courses_path, notice: 'Curso comprado com sucesso'
	end

	def my_courses
		@enrollments = current_student.enrollments
	end

	private

	def set_course
		@course = Course.friendly.find(params[:id])
	end
	def course_params
		params
			.require(:course)
			.permit(%i[name code description price enrollment_deadline teacher_id])
	end
end
