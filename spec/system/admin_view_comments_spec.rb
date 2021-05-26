require 'rails_helper'
describe 'Admin view comments' do
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

		Comment.create!(content: 'Aula muito boa!', lecture: lecture)
		Comment.create!(content: 'Aula sensacional!', lecture: lecture)

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
		visit course_lecture_path(course, lecture)
		expect(page).to have_text('Comentários')
		expect(page).to have_text('Sem comentários ainda')
	end
end
