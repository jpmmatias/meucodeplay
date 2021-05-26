require 'rails_helper'

describe 'Admin registers lessons' do
	it 'sucessufuly' do
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

		visit course_path(course)

		expect(page).to have_link(
			'Cadastrar uma aula',
			href: new_course_lecture_path(course),
		)

		click_on 'Cadastrar uma aula'

		fill_in 'Nome', with: 'Duck Typing'
		fill_in 'Duração', with: 5
		fill_in 'Conteúdo', with: 'Conteúdo do curso'
		fill_in 'Descrição', with: 'Descrição do curso'

		click_on 'Salvar'

		expect(current_path).to eq(course_lecture_path(Lecture.last, course))
		expect(page).to have_content('Aula cadastrada com sucesso')
		expect(page).to have_content('Duck Typing')
		expect(page).to have_content('Conteúdo do curso')
		expect(page).to have_content('Descrição')
		expect(page).to have_link('Voltar')
	end

	it 'fields cannot be empty' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		Course.create!(
			name: 'Ruby',
			description: 'Um curso de Ruby',
			code: 'RUBYBASIC',
			price: 10,
			enrollment_deadline: '22/12/2033',
			teacher: teacher,
		)

		visit course_path(course)

		click_on 'Cadastrar uma aula'

		click_on 'Salvar'

		expect(page).to have_text('não pode ficar em branco', count: 3)
	end
end
