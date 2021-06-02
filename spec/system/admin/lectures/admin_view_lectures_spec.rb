require 'rails_helper'

describe 'Admin view lectures' do
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

		other_course =
			Course.create!(
				name: 'Rails',
				description: 'Um curso de Rails',
				code: 'RAILS',
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
			description: 'Variaveis',
			time: 1,
			content: 'Uma aula de ruby',
			course: course,
		)

		Lecture.create!(
			name: 'Aula pra não ver',
			description: 'Introdução ao Rails',
			time: 20,
			content: 'Uma aula de rails',
			course: other_course,
		)
		user = user_login
		enrollment =
			Enrollment.create!(user: user, course: course, price: course.price)

		visit root_path

		click_on 'Cursos'

		click_on 'Ruby'

		expect(page).to have_content('Aulas')

		expect(page).to have_link('Aula 1')
		expect(page).to have_content('Introdução ao ruby')
		expect(page).to have_content('40 minutos')

		expect(page).to have_link('Aula 2')
		expect(page).to have_content('Variaveis')
		expect(page).to have_content('1 minuto')

		expect(page).not_to have_text('Aula pra não ver')
		expect(page).not_to have_text('Introdução ao Rails')
	end

	it 'and view content' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		user = user_login
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
			content: 'Uma aula de ruby',
			time: 10,
			course: course,
		)

		enrollment =
			Enrollment.create!(user: user, course: course, price: course.price)

		visit root_path

		click_on 'Cursos'

		click_on 'Ruby'

		click_on 'Aula 1'

		expect(page).to have_content('Aula 1')
		expect(page).to have_content('Introdução ao ruby')
		expect(page).to have_content('Uma aula de ruby')

		expect(page).to have_link('Voltar')
	end

	it 'and no lecture is available' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		user = user_login
		course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)
		enrollment =
			Enrollment.create!(user: user, course: course, price: course.price)

		visit root_path
		click_on 'Cursos'
		click_on 'Ruby'

		expect(page).to have_content('Nenhuma aula disponível')
	end
	it 'must be logged in to view courses through route' do
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
				content: 'Uma aula de ruby',
				time: 10,
				course: course,
			)
		visit admin_course_lecture_path(course, lecture)

		expect(current_path).to eq(new_user_session_path)
	end
end
