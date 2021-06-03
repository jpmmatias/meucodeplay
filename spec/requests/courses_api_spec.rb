require 'rails_helper'
describe 'Courses Api' do
	context 'GET /api/v1/courses' do
		it 'should get courses' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)
			Course.create!(
				name: 'Elixir',
				description: 'Um curso de Elixir',
				code: 'ELIXIRBASIC',
				price: 20,
				enrollment_deadline: 1.month.from_now,
				teacher: teacher,
			)

			get '/api/v1/courses'

			expect(response).to have_http_status(200)
			expect(response.content_type).to include('application/json')

			parsed_body = JSON.parse(response.body)

			expect(parsed_body.count).to eq(Course.count)
			expect(parsed_body[0]['name']).to eq('Ruby')
			expect(parsed_body[0]['teacher']['name']).to eq('Jane Doe')
			expect(parsed_body[1]['name']).to eq('Elixir')
			expect(parsed_body[1]['teacher']['name']).to eq('Jane Doe')
		end

		it 'returns no courses' do
			get '/api/v1/courses'

			expect(response).to have_http_status(200)
			expect(response.content_type).to include('application/json')

			parsed_body = JSON.parse(response.body)
			expect(parsed_body).to be_empty
		end
	end

	context 'GET /api/v1/courses/:code' do
		it 'should return a course' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			course =
				Course.create!(
					name: 'Ruby',
					description: 'Um curso de Ruby',
					code: 'RUBYBASIC',
					price: 10,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)
			course2 =
				Course.create!(
					name: 'Elixir',
					description: 'Um curso de Elixir',
					code: 'ELIXIRBASIC',
					price: 20,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)

			get "/api/v1/courses/#{course.code}"

			expect(response.status).to eq(200)
			expect(response.content_type).to include('application/json')
			expect(parsed_body['code']).to include('RUBYBASIC')
			expect(parsed_body['description']).to include('Um curso de Ruby')
		end

		it "shouldn't found a no existing course" do
			get '/api/v1/courses/ABC32PIRJ2OFOOI2MR'
			expect(parsed_body['error']).to eq('Curso não existente')
			expect(response.status).to eq(404)
		end
	end

	context 'POST /api/v1/courses/' do
		it 'should create a course' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			post '/api/v1/courses',
			     params: {
					course: {
						name: 'Ruby on Rails',
						code: 'RUBYONRAILS',
						description: 'Um curso de Ruby on Rails',
						price: 10,
						enrollment_deadline: 1.month.from_now,
						teacher_id: teacher.id,
					},
			     }
			expect(response.status).to eq(201)
			expect(response.content_type).to include('application/json')
			expect(parsed_body['name']).to eq('Ruby on Rails')
			expect(parsed_body['code']).to eq('RUBYONRAILS')
			expect(parsed_body['price']).to eq('10.0')
			expect(parsed_body['description']).to eq('Um curso de Ruby on Rails')
		end

		it 'and attributes cannot be blank' do
			post '/api/v1/courses', params: { course: { code: '' } }
			expect(response.status).to eq(400)
			expect(parsed_body['errors']).to include(
				'Professor(a) não pode ficar em branco',
				'Nome não pode ficar em branco',
				'Código não pode ficar em branco',
				'Preço não pode ficar em branco',
			)
		end

		it 'and must have teacher to create' do
			post '/api/v1/courses', params: { course: { code: '' } }
			expect(response.status).to eq(400)
			expect(parsed_body['errors']).to include('Professor(a) é obrigatório(a)')
		end

		it 'and param is missing' do
			post '/api/v1/courses'
			expect(response.status).to eq(400)
			expect(parsed_body['error']).to include("Param 'course' faltando")
		end
	end

	context 'PUT /api/v1/courses/' do
		it 'should edit a course' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			course =
				Course.create!(
					name: 'Ruby on Rails',
					description: 'Um curso de Ruby on Rails',
					code: 'RUBYONRAILS',
					price: 10,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)

			put '/api/v1/courses/RUBYONRAILS',
			    params: {
					course: {
						name: 'Ruby',
						code: 'RUBYBASIC',
						description: 'Um curso de Ruby',
						price: 20,
						enrollment_deadline: 1.month.from_now,
						teacher_id: teacher.id,
					},
			    }
			expect(response.status).to eq(200)
			expect(response.content_type).to include('application/json')
			expect(parsed_body['name']).to eq('Ruby')
			expect(parsed_body['code']).to eq('RUBYBASIC')
			expect(parsed_body['price']).to eq('20.0')
			expect(parsed_body['description']).to eq('Um curso de Ruby')
		end

		it 'and attributes cannot be blank' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			course =
				Course.create!(
					name: 'Ruby',
					description: 'Um curso de Ruby',
					code: 'RUBYBASIC',
					price: 10,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)
			put '/api/v1/courses/RUBYBASIC',
			    params: {
					course: {
						name: '',
						code: '',
						description: '',
						price: '',
						teacher_id: '',
					},
			    }
			expect(response.status).to eq(400)
			expect(parsed_body['errors']).to include(
				'Professor(a) não pode ficar em branco',
				'Nome não pode ficar em branco',
				'Código não pode ficar em branco',
				'Preço não pode ficar em branco',
			)
		end
		it 'and param is missing' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			course =
				Course.create!(
					name: 'Ruby',
					description: 'Um curso de Ruby',
					code: 'RUBYBASIC',
					price: 10,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)
			put '/api/v1/courses/RUBYBASIC', params: {}
			expect(response.status).to eq(400)
			expect(parsed_body['error']).to include("Param 'course' faltando")
		end

		it "shouldn't edit no existing course" do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			put '/api/v1/courses/NOEXISTINGCOURSE',
			    params: {
					course: {
						name: 'Ruby',
						code: 'RUBYBASIC',
						description: 'Um curso de Ruby',
						price: 20,
						enrollment_deadline: 1.month.from_now,
						teacher_id: teacher.id,
					},
			    }
			expect(response.status).to eq(404)
			expect(parsed_body['error']).to eq('Curso não existente')
		end
	end

	context 'DELETE /api/v1/courses/' do
		it 'should delete course' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			course =
				Course.create!(
					name: 'Ruby',
					description: 'Um curso de Ruby',
					code: 'RUBYBASIC',
					price: 10,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)
			course2 =
				Course.create!(
					name: 'Elixir',
					description: 'Um curso de Elixir',
					code: 'ELIXIRBASIC',
					price: 20,
					enrollment_deadline: 1.month.from_now,
					teacher: teacher,
				)

			delete '/api/v1/courses/RUBYBASIC'

			expect(response.status).to eq(200)
			expect(response.content_type).to include('application/json')
			expect(parsed_body['success']).to eq('Curso deletado com sucesso')
			expect(Course.all.count).to eq(1)
		end

		it 'could not delete a no existing course' do
			delete '/api/v1/courses/NOEXISTINGCOURSE'

			expect(response.status).to eq(404)
			expect(response.content_type).to include('application/json')
			expect(parsed_body['error']).to eq('Curso não existente')
		end
	end
end
