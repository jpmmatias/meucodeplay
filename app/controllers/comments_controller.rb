class CommentsController < ApplicationController
	def create
		lecture = Lecture.friendly.find(params[:lecture_id])
		comment =
			lecture.comments.new(
				content: comment_params[:content],
				student: current_student,
			)

		if comment.save
			course = Course.find(lecture.course_id)
			redirect_to course_lecture_path(course, lecture),
			            notice: 'Comentario enviado com sucesso'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end
end
