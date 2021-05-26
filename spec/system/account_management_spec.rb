require 'rails_helper'

describe 'Account Managment' do
	context 'registration' do
		it 'with name, email and password' do
			visit root_path
			click_on 'Sign Up'
			fill_in 'Nome', with: 'Jane Doe'
			fill_in 'Email', with: 'jane@gmail.com'

			#fill_in 'Confirmar Email', with: 'jane@gmail.com'
			fill_in 'Senha', with: 'Senh@1234'

			#fill_in 'Confirmar senha', with: 'Senh@1234'
			click_on 'Criar conta'

			expect(current_path).to eq(root_path)
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Jane Doe')
			expect(page).to have_link('Cursos')
			expect(page).to_not have_link('Sign Up')
			expect(page).to have_link('Sair')
		end

		it 'without valid field' do
		end

		it 'password not match confirmation' do
		end
	end

	context 'login' do
		it 'with email and password' do
			User.create!(
				email: 'jane@gmail.com',
				password: 'Senh@1234',
				name: 'Jane Doe',
			)
			visit root_path
			click_on 'Login'
			fill_in 'Email', with: 'jane@gmail.com'
			fill_in 'Senha', with: 'Senh@1234'
			within 'form' do
				click_on 'Entrar'
			end
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Jane Doe')
			expect(page).to have_link('Cursos')
			expect(page).to_not have_link('Login')
			expect(page).to have_link('Sair')
		end
	end

	context 'logout' do
	end
end
