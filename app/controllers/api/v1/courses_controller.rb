class Api::V1::CoursesController < ActionController::API
	before_action :set_course, only: %i[edit update show destory]
	def index
		@courses = Course.all
		render json:
				@courses.as_json(
					excpet: %i[id created_at updated_at teacher_id],
					include: [:teacher],
				),
		       status: 200
	end
	def show
		# @lectures = Lecture.where(course_id: @course.id)
		if @course.nil?
			render json: { error: 'Curso não existente' }, status: :not_found
		else
			render json:
					@course.as_json(
						excpet: %i[id created_at updated_at teacher_id],
						include: %i[teacher],
					),
			       status: 200
		end
	end

	def create
		@course = Course.new(course_params)
		if @course.save
			render json:
					@course.as_json(excpet: %i[id teacher_id], include: %i[teacher]),
			       status: :created
		else
			render json: { errors: @course.errors.full_messages }, status: 400
		end
	end

	def update
		if @course.nil?
			render json: { error: 'Curso não existente' }, status: :not_found
		else
			if @course.update(course_params)
				render json:
						@course.as_json(excpet: %i[id teacher_id], include: %i[teacher]),
				       status: 200
			else
				render json: { errors: @course.errors.full_messages }, status: 400
			end
		end
	end

	def destroy
		course = Course.find_by(code: params[:code])
		if course.nil?
			render json: { error: 'Curso não existente' }, status: 404
		else
			if course.destroy!
				render json: { success: 'Curso deletado com sucesso' }, status: 200
			end
		end
	end

	private

	rescue_from ActionController::ParameterMissing do |e|
		render json: { error: "Param 'course' faltando" }, status: :bad_request
	end

	def set_course
		@course = Course.find_by(code: params[:code])
	end
	def course_params
		params
			.require(:course)
			.permit(%i[name code description price enrollment_deadline teacher_id])
	end
end
