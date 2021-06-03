require 'rails_helper'

describe 'Student view categories in course page' do
	it 'successfully' do
		Categorie.create!(name: 'Desenvolvimento Web')
		Categorie.create!(name: 'OPP')
		Categorie.create!(name: 'Programação funcional')

		visit courses_path

		expect(page).to have_text('Categorias')
		expect(page).to have_link('Desenvolvimento Web')
		expect(page).to have_link('OPP')
		expect(page).to have_link('Programação funcional')
	end

	it 'and view courses that includes categorie' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')

		categorie = Categorie.create!(name: 'Desenvolvimento Web')
		categorie2 = Categorie.create!(name: 'Microcontroladores')

		Course.create!(
			name: 'Ruby',
			description: 'Um curso de Ruby',
			code: 'RUBYBASIC',
			price: 10,
			enrollment_deadline: '22/12/2033',
			teacher: teacher,
			categorie: categorie,
		)

		Course.create!(
			name: 'Elixir',
			description: 'Um curso de Elixir',
			code: 'ELIXIRBASIC',
			price: 20,
			enrollment_deadline: '22/12/2033',
			teacher: teacher,
			categorie: categorie,
		)

		Course.create!(
			name: 'C++',
			description: 'Um curso de C++',
			code: 'CPLUSPLUSBASIC',
			price: 10,
			enrollment_deadline: '22/12/2033',
			teacher: teacher,
			categorie: categorie2,
		)

		visit courses_path

		expect(page).to have_link('Desenvolvimento Web')
		expect(page).to have_link('Microcontroladores')

		click_on 'Desenvolvimento Web'

		expect(page).to have_link('Ruby')
		expect(page).to have_link('Elixir')
		expect(page).not_to have_link('C++')
	end

	it "don't have courses on categorie" do
		Categorie.create!(name: 'Desenvolvimento Web')
		visit courses_path
		click_on 'Desenvolvimento Web'
		expect(page).to have_text 'Categoria sem cursos'
	end
end
