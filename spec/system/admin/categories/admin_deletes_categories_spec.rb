require 'rails_helper'

describe 'Admin deletes categories' do
	it 'successfully' do
		category = Categorie.create!(name: 'OOP')

		user_login
		visit admin_categories_path

		expect(page).to have_link('Deletar')

		click_on 'Deletar'

		expect(Course.count).to eq(0)

		expect(page).to have_content('Categoria deletada com sucesso')
	end
end
