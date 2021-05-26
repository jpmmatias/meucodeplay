require 'rails_helper'

describe 'Admin deletes lectures' do
	it 'successfully' do
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

		Lecture.create!(
			name: 'Aula 1',
			description: 'Introdução ao ruby',
			time: 40,
			content: 'Uma aula de ruby',
			course: course,
		)

		Lecture.create!(
			name: 'Aula 2',
			description: 'Introdução ao ruby',
			time: 40,
			content: 'Uma aula de ruby',
			course: course,
		)

		visit course_path(course)

		expect(page).to have_link('Deletar', count: 3)
		all('a', text: 'Deletar')[1].click
		expect(page).to have_text('Aula deletada com sucesso')
		expect(page).to have_link('Deletar', count: 2)
	end
end
