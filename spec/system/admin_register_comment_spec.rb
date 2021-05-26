require 'rails_helper'

describe 'Admin comment leture' do
	it 'sucessfully' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)

		lecture =
			Lecture.create!(
				name: 'Aula 1',
				description: 'Introdução ao ruby',
				time: 40,
				content: 'Uma aula de ruby',
				course: course,
			)

		visit course_lecture_path(course, lecture)

		fill_in 'Escreva comentário', with: 'Melhor comentario'

		click_on('Enviar comentário')

		expect(page).to have_text('Comentario enviado com sucesso')
		expect(page).to have_text('Melhor comentario')
	end
end
