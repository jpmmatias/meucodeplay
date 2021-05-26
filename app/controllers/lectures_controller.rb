class LecturesController < ApplicationController
	before_action :get_lecture, only: %i[edit update show destory]
	before_action :get_course, only: %i[new create show]
	def new
		@lecture = Lecture.new
	end

	def create
		@lecture = @course.lectures.new(lecture_params)
		if @lecture.save
			redirect_to course_lecture_path(@course, @lecture),
			            notice: t('lectures.create.success')
		else
			render :new
		end
	end

	def show; end

	private

	def get_lecture
		@lecture = Lecture.find(params[:id])
	end

	def get_course
		@course = Course.find(params[:course_id])
	end

	def lecture_params
		params.require(:lecture).permit(:name, :time, :description, :content)
	end
end
