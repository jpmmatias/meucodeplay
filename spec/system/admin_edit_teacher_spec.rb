require 'rails_helper'

describe 'Admin edit teachers information' do
	it 'from index page' do
		@teacher =
			Teacher.create(
				name: 'Henrique',
				bio: 'Um professor de Ruby on Rails',
				email: 'henrique@gmail.com',
				profile_picture:
					Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
			)

		visit root_path
		click_on 'Professores'
		expect(page).to have_link('Editar', href: edit_teacher_path(@teacher))
	end

	it 'sucessufuly' do
		@teacher =
			Teacher.create(
				name: 'Henrique',
				bio: 'Um professor de Ruby on Rails',
				email: 'henrique@gmail.com',
				profile_picture:
					Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
			)
		visit root_path
		click_on 'Professores'
		click_on 'Editar'
		expect(page).to have_link('Cancelar')
		fill_in 'Nome', with: 'João'
		fill_in 'Email', with: 'joao@gmail.com'
		attach_file('Foto de perfil', 'spec/fixtures/teste.png')

		click_on 'Salvar'

		expect(current_path).to eq(teacher_path('joao'))
		expect(page).to have_content('João')
		expect(page).to have_content('Um professor de Ruby on Rails')
		expect(page).to have_content('joao@gmail.com')
		expect(page).to have_css('img')
		expect(page).to have_link('Voltar')
	end
end
