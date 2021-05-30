require 'rails_helper'

describe 'admin updates lectures' do
	it 'sucessfully' do
		user =
			User.create!(email: 'joão@gmail.com', name: 'João', password: 'Senh@1234')
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

		enrollment =
			Enrollment.create!(user: user, course: course, price: course.price)

		login_as user, scope: :user

		visit course_path(course)

		expect(page).to have_link('Aula 1')
		expect(page).to have_content('Introdução ao ruby')
		expect(page).to have_content('40 minutos')

		expect(page).to have_link(
			'Editar',
			href: edit_course_lecture_path(course, lecture),
		)

		all('a', text: 'Editar')[1].click

		expect(page).to have_text('Editar Aula')

		fill_in 'Nome', with: 'Curso do Hype'
		fill_in 'Duração', with: 22
		fill_in 'Conteúdo', with: 'Conteúdo do curso 2'
		fill_in 'Descrição', with: 'Descrição do curso 2'

		click_on 'Salvar'

		expect(page).to have_link('Curso do Hype')
		expect(page).to have_content('Descrição do curso 2')
		expect(page).to have_content('2 minutos')

		expect(page).to have_text('Aula atualizada com sucesso')
	end
end
