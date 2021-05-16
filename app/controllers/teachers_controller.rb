class TeachersController < ApplicationController
	before_action :set_teacher, only: %i[show]
	before_action :teacher_params, only: %i[create]
	def index
		@teachers = Teacher.all
	end
	def show; end
	def new
		@teacher = Teacher.new
	end
	def create
		if @teacher.save
			redirect_to @teacher
		else
			render :new
		end
	end

	private

	def set_teacher
		@teacher = Teacher.find(params[:id])
	end

	def teacher_params
		@teacher =
			Teacher.new(
				params.require(:teacher).permit(:name, :profile_picture, :bio, :email),
			)
	end
end
