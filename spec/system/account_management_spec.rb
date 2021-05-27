require 'rails_helper'

describe 'Account Managment' do
	context 'registration' do
		it 'with name, email and password' do
			visit root_path
			click_on 'Sign Up'
			fill_in 'Nome', with: 'Jane Doe'
			fill_in 'Email', with: 'jane@gmail.com'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'Senh@1234'
			click_on 'Criar conta'

			expect(current_path).to eq(root_path)
			expect(page).to have_text('Login efetuado com sucesso')
			expect(page).to have_text('Jane Doe')
			expect(page).to have_link('Cursos')
			expect(page).to_not have_link('Sign Up')
			expect(page).to have_link('Sair')
		end

		it 'without valid field' do
			visit root_path
			click_on 'Sign Up'
			click_on 'Criar conta'

			expect(page).to have_content('não pode ficar em branco', count: 3)
		end

		it 'password not match confirmation' do
			visit root_path
			click_on 'Sign Up'
			fill_in 'Nome', with: 'Jane Doe'
			fill_in 'Email', with: 'jane@gmail.com'
			fill_in 'Senha', with: 'Senh@1234'
			fill_in 'Confirmação de senha', with: 'SenhaErrada'
			click_on 'Criar conta'

			expect(page).to have_content('Confirmação de senha não é igual a Senha')
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

		it 'with wrong credentials' do
			User.create!(
				email: 'jane@gmail.com',
				password: 'Senh@1234',
				name: 'Jane Doe',
			)
			visit root_path
			click_on 'Login'
			fill_in 'Email', with: 'jane@gmail.com'
			fill_in 'Senha', with: 'SenhaErrada'
			within 'form' do
				click_on 'Entrar'
			end
			expect(page).to have_text('Email ou senha inválida.')
		end
	end

	context 'logout' do
		it 'successfully' do
			user =
				User.create!(
					email: 'jane@gmail.com',
					name: 'Jane Doe',
					password: 'Senh@1234',
				)

			visit root_path
			click_on 'Login'
			fill_in 'Email', with: 'jane@gmail.com'
			fill_in 'Senha', with: 'Senh@1234'
			within 'form' do
				click_on 'Entrar'
			end
			click_on 'Sair'

			expect(page).to have_text('Saiu com sucesso')
			expect(page).to_not have_text('Jane Doe')
			expect(current_path).to eq(root_path)
			expect(page).to have_link('Sign Up')
			expect(page).to have_link('Login')
			expect(page).to_not have_link('Sair')
		end
	end

	context 'password recovey' do
		it 'successfully' do
			user =
				User.create!(
					email: 'jane@gmail.com',
					name: 'Jane Doe',
					password: 'Senh@1234',
				)
			visit root_path
			click_on 'Login'
			expect(page).to have_link('Esqueci minha senha')
			click_on ('Esqueci minha senha')

			fill_in 'Email', with: 'jane@gmail.com'
			click_on('Enviar')
			expect(current_path).to eq(new_user_session_path)
			expect(page).to (
				'Dentro de minutos, você receberá um e-mail com instruções para a troca da sua senha.'
			)
		end
	end
end
