require 'rails_helper'

describe 'Admin registers categories' do
	it 'from index page' do
		user_login
		visit root_path
		click_on 'Categorias'

		expect(page).to have_link(
			'Registrar uma Categoria',
			href: new_admin_category_path,
		)
	end

	it 'successfully' do
		user_login
		visit root_path
		click_on 'Categorias'
		click_on 'Registrar uma Categoria'

		fill_in 'Nome', with: 'OOP'

		click_on 'Criar categoria'

		expect(current_path).to eq(admin_categories_path)
		expect(page).to have_content('OOP')
		expect(page).to have_link('Voltar')
	end

	it 'and attributes cannot be blank' do
		user_login
		visit root_path
		click_on 'Categorias'
		click_on 'Registrar uma Categoria'
		fill_in 'Nome', with: ''

		click_on 'Criar categoria'

		expect(page).to have_content('não pode ficar em branco', count: 1)
	end

	it 'and code must be unique' do
		Categorie.create!(name: 'OOP')
		user_login

		visit root_path
		click_on 'Categorias'
		click_on 'Registrar uma Categoria'
		fill_in 'Nome', with: 'OOP'
		click_on 'Criar categoria'

		expect(page).to have_content('já está em uso')
	end
end
