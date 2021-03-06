require 'rails_helper'

describe 'User authentication' do
	context 'courses' do
		it 'cannot access create without login' do
			post admin_courses_path, params: { course: { name: 'Ruby' } }

			expect(response).to redirect_to new_user_session_path
			expect(response.status).to eq(302)
		end

		it 'cannot access edit without login' do
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
			put admin_course_path(course), params: { course: { name: 'Elixir' } }

			expect(response).to redirect_to new_user_session_path
			expect(response.status).to eq(302)
		end

		it 'cannot access delete without login' do
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

			delete admin_course_path(course)

			expect(response).to redirect_to new_user_session_path
			expect(response.status).to eq(302)
		end
	end

	context 'categories' do
		it 'cannot access create without login' do
			post admin_categories_path, params: { categorie: { name: 'OOP' } }

			expect(response).to redirect_to new_user_session_path
			expect(response.status).to eq(302)
		end
		it 'cannot access edit without login' do
			category = Categorie.create(name: 'TDD')
			put admin_category_path(category), params: { categorie: { name: 'OOP' } }

			expect(response).to redirect_to new_user_session_path
			expect(response.status).to eq(302)
		end
		it 'cannot access delete without login' do
			category = Categorie.create(name: 'TDD')

			delete admin_category_path(category)

			expect(response).to redirect_to new_user_session_path
			expect(response.status).to eq(302)
		end
	end
end
