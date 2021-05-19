require 'rails_helper'

describe 'Admin registers teachers' do
	it 'from index page' do
		visit root_path
		click_on 'Professores'

		expect(page).to have_link('Registrar um Professor', href: new_teacher_path)
	end

	it 'successfully' do
		visit root_path
		click_on 'Professores'
		click_on 'Registrar um Professor'

		fill_in 'Nome', with: 'Henrique'
		fill_in 'Bio', with: 'Um professor de Ruby on Rails'
		fill_in 'Email', with: 'henrique@gmail.com'
		attach_file('Foto de perfil', 'spec/fixtures/teste.png')
		click_on 'Criar professor'

		expect(current_path).to eq(teacher_path(Teacher.last))
		expect(page).to have_content('Henrique')
		expect(page).to have_content('Um professor de Ruby on Rails')
		expect(page).to have_content('henrique@gmail.com')
		expect(page).to have_css('img')
		expect(page).to have_link('Voltar')
	end

	it 'and attributes cannot be blank' do
		Teacher.create!(
			name: 'Henrique',
			bio: 'Um professor de Ruby on Rails',
			email: 'henrique@gmail.com',
			profile_picture: Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
		)

		visit root_path
		click_on 'Professores'
		click_on 'Registrar um Professor'
		fill_in 'Nome', with: ''
		fill_in 'Bio', with: ''
		fill_in 'Email', with: ''
		click_on 'Criar professor'

		expect(page).to have_content('não pode ficar em branco', count: 2)
	end

	it 'and code must be unique' do
		Teacher.create!(
			name: 'Henrique',
			bio: 'Um professor de Ruby on Rails',
			email: 'henrique@gmail.com',
			profile_picture: Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
		)

		visit root_path
		click_on 'Professor'
		click_on 'Registrar um Professor'
		fill_in 'Email', with: 'henrique@gmail.com'
		click_on 'Criar professor'

		expect(page).to have_content('email já está em uso')
	end
end
