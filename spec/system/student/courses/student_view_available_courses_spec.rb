require 'rails_helper'

describe 'Student view courses on homepage' do
	it 'with enrollment still available' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

		course_unavailable =
			Course.create!(
				name: 'CSS',
				description: 'Um curso de CSS',
				code: 'CSSBASIC',
				price: 10,
				enrollment_deadline: 2.day.ago,
				teacher: teacher,
			)

		visit root_path
		expect(page).to have_content('Cursos Disponíveis')
		expect(page).to have_link('HTML')
		expect(page).to have_content(course_available.description)
		expect(page).to have_content('R$ 10,00')
		expect(page).not_to have_content('CSS')
	end

	it 'and view enrollment link' do
		student =
			Student.create!(
				email: 'joão@gmail.com',
				name: 'João',
				password: 'Senh@1234',
			)
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)
		login_as student, scope: :student
		visit root_path
		click_on 'HTML'

		expect(page).to have_link 'Comprar'
	end

	it 'and view enrollment link' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

		visit root_path
		click_on 'HTML'

		expect(page).to_not have_link 'Comprar'
		expect(page).to have_link('login', href: new_student_session_path)
		expect(page).to have_content('Faça login para comprar esse curso')
	end

	it 'does not view with enrollment_deadeline over' do
		student =
			Student.create!(
				email: 'joão@gmail.com',
				name: 'João',
				password: 'Senh@1234',
			)

		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')

		course_unavailable =
			Course.create!(
				name: 'CSS',
				description: 'Um curso de CSS',
				code: 'CSSBASIC',
				price: 10,
				enrollment_deadline: 2.day.ago,
				teacher: teacher,
			)

		login_as student, scope: :student

		visit course_path(course_unavailable)

		expect(page).not_to have_link 'Comprar'
		expect(page).to have_content('Praso de inscrição de curso terminou')
	end

	it 'and buy a course' do
		student =
			Student.create!(
				email: 'joão@gmail.com',
				name: 'João',
				password: 'Senh@1234',
			)
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')

		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

		other_course_available =
			Course.create!(
				name: 'Elixir',
				description: 'Um curso de HTML',
				code: 'ELIXIRBASIC',
				price: 20,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

		login_as student, scope: :student

		visit course_path(course_available)

		click_on 'Comprar'

		expect(page).to have_content('Curso comprado com sucesso')

		expect(current_path).to eq(my_courses_courses_path)

		expect(page).to have_content('HTML')
		expect(page).to have_content('R$ 10,00')

		expect(page).not_to have_content('Elixir')
		expect(page).not_to have_content('R$ 20,00')
	end

	it 'and cannot buy course twice' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')

		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)
		Lecture.create!(
			name: 'Tags de texto',
			description: 'Faça textos no html com: H1, H2, H3, H4',
			content: 'Conteudo de HTML',
			time: 10,
			course: course_available,
		)
		student = student_login
		enrollment =
			Enrollment.create!(
				student: student,
				course: course_available,
				price: course_available.price,
			)

		visit course_path(course_available)

		expect(page).not_to have_link 'Comprar'
		expect(page).to have_link 'Tags de texto'
	end

	it 'without enrollment cannot view lesson link' do
		student = student_login
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')

		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)
		Lecture.create!(
			name: 'Tags de texto',
			description: 'Faça textos no html com: H1, H2, H3, H4',
			content: 'Conteudo de HTML',
			time: 10,
			course: course_available,
		)

		visit course_path(course_available)

		expect(page).to have_link 'Comprar'
		expect(page).not_to have_content 'Aulas'
		expect(page).not_to have_link 'Tags de texto'
	end
end
