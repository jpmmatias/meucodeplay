require 'rails_helper'

describe Course do
	context 'validation' do
		subject { Course.new }
		it 'attributes cannot be blank' do
			subject.valid?

			expect(subject.errors[:name]).to include('não pode ficar em branco')
			expect(subject.errors[:code]).to include('não pode ficar em branco')
			expect(subject.errors[:price]).to include('não pode ficar em branco')
		end

		it 'code must be uniq' do
			teacher = Teacher.create!(name: 'Jane Doe', email: 'jane@gmail.com')
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
				teacher: teacher,
			)
			course = Course.new(code: 'RUBYBASIC')

			course.valid?

			expect(course.errors[:code]).to include('já está em uso')
		end
	end
end
