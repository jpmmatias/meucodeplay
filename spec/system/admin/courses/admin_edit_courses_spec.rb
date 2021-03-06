require 'rails_helper'

describe 'admin updates courses' do
	it 'sucessfully' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		teacher2 = Teacher.create!(name: 'Henrique', email: 'henrique@gmail.com')
		@course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)
		enrollment_date = 10.days.from_now

		user_login

		visit admin_course_path(@course)

		click_on 'Editar'

		fill_in 'Nome', with: 'Ruby on Rails'
		fill_in 'Descrição', with: 'Um curso de ROR'
		fill_in 'Código', with: 'RUBYONRAILS'
		fill_in 'Preço', with: '3000'
		fill_in 'Data limite de matrícula', with: enrollment_date
		select "#{teacher2.name} - #{teacher2.email}", from: 'Professor(a)'

		click_on 'Salvar'

		expect(page).to have_text('Ruby on Rails')
		expect(page).to have_text('Um curso de ROR')
		expect(page).to have_text('RUBYONRAILS')
		expect(page).to have_text('R$ 3.000,00')
		expect(page).to have_text(enrollment_date.strftime('%d/%m/%Y'))
		expect(page).to have_text("#{teacher2.name}")

		expect(page).to have_text('Curso atualizado com sucesso')
	end
	it 'must be logged in to view course edit button' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		@course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)
		visit admin_course_path(@course)
		expect(page).not_to have_link('Editar')
	end

	it 'must be logged in to edit courses through route' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		@course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)
		visit edit_admin_course_path(@course)

		expect(current_path).to eq(new_user_session_path)
	end

	it 'edit category of the course' do
		user_login
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		category = Categorie.create!(name: 'OOP')
		categoy2 = Categorie.create!(name: 'TDD')

		@course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
				categorie: category,
			)
		visit edit_admin_course_path(@course)
		select categoy2.name, from: 'Categoria'
		click_on 'Salvar'

		expect(page).to have_content('TDD')
	end
end
