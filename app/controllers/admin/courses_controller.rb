class Admin::CoursesController < ApplicationController
	before_action :set_course, only: %i[show edit update destroy enroll]
	def index
		@courses = Course.all
	end
	def show
		@lectures = Lecture.where(course_id: @course.id)
	end

	def new
		@course = Course.new
		@teachers = Teacher.all
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			redirect_to [:admin, @course], notice: 'Curso criado com sucesso'
		else
			@teachers = Teacher.all
			render :new
		end
	end

	def edit
		@teachers = Teacher.all
	end

	def update
		if @course.update(course_params)
			redirect_to [:admin, @course], notice: t('.success')
		else
			flash[:alert] = @course.errors.full_messages
			render :edit
		end
	end

	def destroy
		Course.friendly.destroy(params[:id])
		redirect_to admin_courses_path, notice: 'Curso deletado com sucesso'
	end

	def enroll
		current_user.enrollments.create(course: @course, price: @course.price)

		redirect_to my_courses_courses_path, notice: 'Curso comprado com sucesso'
	end

	def my_courses
		@enrollments = current_user.enrollments
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
