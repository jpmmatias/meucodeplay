require 'rails_helper'

describe 'Admin deletes courses' do
	it 'successfully' do
		@course =
			Course.create!(
				name: 'Ruby',
				description: 'Um curso de Ruby',
				code: 'RUBYBASIC',
				price: 10,
				enrollment_deadline: '22/12/2033',
			)

		visit course_path(@course)

		click_on 'Deletar'

		expect(Course.count).to eq(0)

		expect(current_path).to eq(courses_path)
	end
end
