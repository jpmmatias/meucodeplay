require 'rails_helper'

describe 'Admin edit categories' do
	it 'succesufuly' do
		categorie = Categorie.create!(name: 'OOP')

		user_login
		visit admin_categories_path

		expect(page).to have_link(
			'Editar',
			href: edit_admin_category_path(categorie),
		)
		click_on('Editar')
		expect(current_path).to eq(edit_admin_category_path(categorie))

		fill_in 'Nome', with: 'TDD'

		click_on('Concluir')

		expect(current_path).to eq(admin_categories_path)

		expect(page).to have_text('TDD')
		expect(page).not_to have_text('OOP')
	end

	it "can't be blank" do
		categorie = Categorie.create!(name: 'OOP')
		user_login
		visit edit_admin_category_path(categorie)

		fill_in 'Nome', with: ''

		click_on('Concluir')

		expect(page).to have_content('não pode ficar em branco')
	end

	it 'and code must be unique' do
		categorie = Categorie.create!(name: 'OOP')
		Categorie.create!(name: 'Web Dev')
		user_login

		visit edit_admin_category_path(categorie)
		fill_in 'Nome', with: 'Web Dev'
		click_on 'Concluir'

		expect(page).to have_content('já está em uso')
	end
end
