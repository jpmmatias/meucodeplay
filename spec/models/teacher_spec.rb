require 'rails_helper'

describe Teacher do
	context 'validation' do
		it { should have_many(:courses) }

		it do
			should validate_presence_of(:name).with_message(
					'não pode ficar em branco',
			       )
		end

		it do
			should validate_presence_of(:email).with_message(
					'não pode ficar em branco',
			       )
		end
		it do
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
