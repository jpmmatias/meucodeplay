class TeachersController < ApplicationController
	before_action :set_teacher, only: %i[show edit update]
	def index
		@teachers = Teacher.all
	end
	def show; end
	def new
		@teacher = Teacher.new
	end
	def create
		@teacher = Teacher.new(teacher_params)
		if @teacher.save
			redirect_to @teacher
		else
			render :new
		end
	end
	def edit; end

	def update
		if @teacher.update(teacher_params)
			redirect_to @teacher
		else
			render :edit
		end
	end

	def destroy
		Teacher.destroy((params[:id]))
		redirect_to teachers_url
	end

	private

	def set_teacher
		@teacher = Teacher.find(params[:id])
	end

	def teacher_params
		params.require(:teacher).permit(:name, :profile_picture, :bio, :email)
	end
end
