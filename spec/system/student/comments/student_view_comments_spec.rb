require 'rails_helper'
describe 'Student view comments' do
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
		student = student_login
		enrollment =
			Enrollment.create!(student: student, course: course, price: course.price)

		Comment.create!(
			content: 'Aula muito boa!',
			lecture: lecture,
			student: student,
		)
		Comment.create!(
			content: 'Aula sensacional!',
			lecture: lecture,
			student: student,
		)

		visit course_lecture_path(course, lecture)

		expect(page).to have_text('Comentários')
		expect(page).to have_text('Aula muito boa!')
		expect(page).to have_text('Aula sensacional!')
	end

	it "and don't have comments" do
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
		student = student_login
		enrollment =
			Enrollment.create!(student: student, course: course, price: course.price)
		visit course_lecture_path(course, lecture)
		expect(page).to have_text('Comentários')
		expect(page).to have_text('Sem comentários ainda')
	end
end
