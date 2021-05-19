require 'rails_helper'

describe 'Admin view teachers' do
	it 'successfully' do
		Teacher.create!(
			name: 'Diogo Cortiz',
			email: 'diogo@gmail.com',
			bio:
				'Sou professor do curso de Ciência de Dados e Design de Interação da PUC-SP',
			profile_picture: Rack::Test::UploadedFile.new('spec/fixtures/teste.png'),
		)
		visit root_path
		click_on 'Professores'
		expect(page).to have_content('Diogo Cortiz')
		expect(page).to have_content('diogo@gmail.com')
		expect(page).to have_content(
			'Sou professor do curso de Ciência de Dados e Design de Interação da PUC-SP',
		)
		expect(page).to have_css('img[src*="teste.png"]')
	end
end
