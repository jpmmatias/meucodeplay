require 'rails_helper'

describe 'admin updates courses' do
	it 'sucessfully' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		@course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)
		enrollment_date = 10.days.from_now

		visit course_path(@course)

		click_on 'Editar'

		fill_in 'Nome', with: 'Ruby on Rails'
		fill_in 'Descrição', with: 'Um curso de ROR'
		fill_in 'Código', with: 'RUBYONRAILS'
		fill_in 'Preço', with: '3000'
		fill_in 'Data limite de matrícula', with: enrollment_date

		click_on 'Salvar'

		expect(page).to have_text('Ruby on Rails')
		expect(page).to have_text('Um curso de ROR')
		expect(page).to have_text('RUBYONRAILS')
		expect(page).to have_text('R$ 3.000,00')
		expect(page).to have_text(enrollment_date.strftime('%d/%m/%Y'))

		expect(page).to have_text('Curso atualizado com sucesso')
	end
end
