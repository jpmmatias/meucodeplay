require 'rails_helper'

describe 'Admin view all students enrollments' do
	it 'successufuly' do
		user_login
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)

		course2 =
			Course.create!(
				name: 'Elixir',
				description: 'Um curso de Elixir',
				code: 'ELIXIRBASIC',
				price: 20,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)

		student =
			Student.create!(
				email: 'joãoestudante@gmail.com',
				name: 'João Estudante',
				password: 'Senh@1234',
			)

		student2 =
			Student.create!(
				email: 'joãoestudante2@gmail.com',
				name: 'João Estudante 2',
				password: 'Senh@1234',
			)

		Enrollment.create!(student: student, course: course, price: course)

		Enrollment.create!(student: student, course: course2, price: course2.price)

		Enrollment.create!(student: student2, course: course2, price: course2.price)

		visit root_path

		expect(page).to have_link(
			'Compras de Estudantes',
			href: admin_enrollments_path,
		)

		click_on('Compras de Estudantes')

		expect(page).to have_text('Todas as compras')
		expect(page).to have_text('João Estudante')
		expect(page).to have_text('Ruby')
		expect(page).to have_text('R$ 10,00')
		expect(page).to have_text('João Estudante 2')
		expect(page).to have_text('Elixir')
		expect(page).to have_text('R$ 20,00')

		expect(page).to have_link('Voltar')
	end

	it "and don't have enrollments" do
		user_login
		visit admin_enrollments_path
		expect(page).to have_text('Todas as compras')
		expect(page).to have_content('Nenhuma compra efetuada')
	end
end
