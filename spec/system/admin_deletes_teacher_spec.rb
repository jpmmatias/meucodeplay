require 'rails_helper'

describe 'Admin deletes teacher' do
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
		expect(page).to have_link('Deletar', href: teacher_path(@teacher))
	end

	it 'sucessufuly' do
		Teacher.create!(
			name: 'Henrique',
			bio: 'Um professor de Ruby on Rails',
			email: 'henrique@gmail.com',
			profile_picture: Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
		)

		Teacher.create!(
			name: 'Diogo Cortiz',
			email: 'diogo@gmail.com',
			bio:
				'Sou professor do curso de Ciência de Dados e Design de Interação da PUC-SP',
			profile_picture: Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
		)

		visit root_path
		click_on 'Professores'
		first('a[data-method *= "delete"]').click
		expect(page).to have_css('a[data-method*="delete"]', count: 1)
	end
end
