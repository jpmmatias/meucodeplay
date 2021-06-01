class Admin::LecturesController < ApplicationController
	before_action :get_lecture, only: %i[edit update show destroy]
	before_action :get_course, only: %i[new edit update create show destroy]

	def new
		@lecture = Lecture.new
	end

	def create
		@lecture = @course.lectures.new(lecture_params)
		if @lecture.save
			redirect_to admin_course_lecture_path(@course, @lecture),
			            notice: t('lectures.create.success')
		else
			render :new
		end
	end

	def show
		@comments = Comment.all
		@comment = Comment.new
	end

	def edit; end

	def update
		if @lecture.update(lecture_params)
			redirect_to admin_course_path(@course),
			            notice: 'Aula atualizada com sucesso'
		else
			render :edit
		end
	end

	def destroy
		@lecture.destroy
		redirect_to admin_course_path(@course), notice: 'Aula deletada com sucesso'
	end

	private

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
