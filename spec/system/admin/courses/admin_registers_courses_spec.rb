require 'rails_helper'
describe 'Admin registers courses' do
	it 'from index page' do
		user_login
		visit root_path
		click_on 'Cursos'

		expect(page).to have_link('Registrar um Curso', href: new_admin_course_path)
	end

	it 'successfully' do
		user_login
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		visit root_path
		click_on 'Cursos'
		click_on 'Registrar um Curso'

		fill_in 'Nome', with: 'Ruby on Rails'
		fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
		fill_in 'Código', with: 'RUBYONRAILS'
		fill_in 'Preço', with: '30'
		fill_in 'Data limite de matrícula', with: '22/12/2033'
		attach_file 'Banner', Rails.root.join('spec/fixtures/course.jpg')
		select "#{teacher.name} - #{teacher.email}", from: 'Professor(a)'

		click_on 'Criar curso'

		expect(current_path).to eq(admin_course_path(Course.last))
		expect(page).to have_content('Ruby on Rails')
		expect(page).to have_content('Um curso de Ruby on Rails')
		expect(page).to have_content('Jane Doe')
		expect(page).to have_content('RUBYONRAILS')
		expect(page).to have_content('R$ 30,00')
		expect(page).to have_content('22/12/2033')
		expect(page).to have_css('img[src*="course.jpg"]')
		expect(page).to have_link('Voltar')
	end

	it 'and attributes cannot be blank' do
		user_login
		visit root_path
		click_on 'Cursos'
		click_on 'Registrar um Curso'

		click_on 'Criar curso'

		expect(page).to have_content('não pode ficar em branco', count: 4)
	end

	it 'and code must be unique' do
		user_login
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		Course.create!(
			name: 'Ruby',
			description: 'Um curso de Ruby',
			code: 'RUBYBASIC',
			price: 10,
			enrollment_deadline: '22/12/2033',
			teacher: teacher,
		)

		visit root_path
		click_on 'Cursos'
		click_on 'Registrar um Curso'
		fill_in 'Código', with: 'RUBYBASIC'
		click_on 'Criar curso'

		expect(page).to have_content('já está em uso')
	end

	it 'must be logged in to create courses through route' do
		visit new_admin_course_path

		expect(current_path).to eq(new_user_session_path)
	end

	it 'course can have a category' do
		user_login
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		categoy = Categorie.create!(name: 'OOP')

		visit admin_courses_path
		click_on 'Registrar um Curso'

		fill_in 'Nome', with: 'Ruby on Rails'
		fill_in 'Descrição', with: 'Um curso de Ruby on Rails'
		fill_in 'Código', with: 'RUBYONRAILS'
		fill_in 'Preço', with: '30'
		fill_in 'Data limite de matrícula', with: '22/12/2033'
		attach_file 'Banner', Rails.root.join('spec/fixtures/course.jpg')
		select "#{teacher.name} - #{teacher.email}", from: 'Professor(a)'
		select categoy.name, from: 'Categoria'
		click_on 'Criar curso'

		expect(current_path).to eq(admin_course_path(Course.last))
		expect(page).to have_content('OOP')
	end
end
