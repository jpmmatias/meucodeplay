class CoursesController < ApplicationController
	before_action :set_course, only: %i[show edit update destroy]
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
			redirect_to @course, notice: 'Curso criado com sucesso'
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
			redirect_to @course, notice: t('.success')
		else
			flash[:alert] = @course.errors.full_messages
			render :edit
		end
	end

	def destroy
		Course.friendly.destroy(params[:id])
		redirect_to courses_path, notice: 'Curso deletado com sucesso'
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
