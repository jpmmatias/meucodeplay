require 'rails_helper'

RSpec.describe Lecture, type: :model do
	it 'attributes cannot be blank' do
		lecture = Lecture.new
		lecture.valid?

		expect(lecture.errors[:name]).to include('não pode ficar em branco')
		expect(lecture.errors[:content]).to include('não pode ficar em branco')
		expect(lecture.errors[:time]).to include('não pode ficar em branco')
	end
end
