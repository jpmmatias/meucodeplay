require 'rails_helper'

describe Teacher do
	context 'validation' do
		it 'attributes cannot be blank' do
			teacher = Teacher.new

			teacher.valid?

			expect(teacher.errors[:name]).to include('não pode ficar em branco')
			expect(teacher.errors[:email]).to include('não pode ficar em branco')
		end

		it 'email must be uniq' do
			Teacher.create!(
				name: 'Henrique',
				bio: 'Professor de Ruby',
				email: 'henrique@gmail.com',
			)
			teacher = Teacher.new(email: 'henrique@gmail.com')

			teacher.valid?

			expect(teacher.errors[:email]).to include('já está em uso')
		end
	end
end
