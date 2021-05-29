require 'rails_helper'

describe 'Student view courses on homepage' do
	it 'with enrollment still available' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

		course_unavailable =
			Course.create!(
				name: 'CSS',
				description: 'Um curso de CSS',
				code: 'CSSBASIC',
				price: 10,
				enrollment_deadline: 1.day.ago,
				teacher: teacher,
			)

		visit root_path

		expect(page).to have_content('HTML')
		expect(page).to have_content(course_available.description)
		expect(page).to have_content('R$ 10,00')
		expect(page).not_to have_content('CSS')
	end

	it 'does not view with enrollment_deadeline over' do
	end

	it 'and view enrollment link' do
		user =
			User.create!(email: 'joão@gmail.com', name: 'João', password: 'Senh@1234')
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)
		login_as user, scope: user
		visit root_path
		click_on 'HTML'

		expect(page).to have_link 'Comprar'
	end

	it 'and view enrollment link' do
		teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
		course_available =
			Course.create!(
				name: 'HTML',
				description: 'Um curso de HTML',
				code: 'HTMLBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

		visit root_path
		click_on 'HTML'

		expect(page).to_not have_link 'Comprar'
		expect(page).to have_content('Faça login para comprar esse curso')
	end
end
