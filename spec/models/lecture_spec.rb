require 'rails_helper'

RSpec.describe Lecture, type: :model do
	it { should belong_to(:course) }

	context 'validation' do
		it do
			should validate_presence_of(:name).with_message(
					'não pode ficar em branco',
			       )
		end
		it do
			should validate_presence_of(:content).with_message(
					'não pode ficar em branco',
			       )
		end
		it do
			should validate_presence_of(:time).with_message(
					'não pode ficar em branco',
			       )
		end
	end
end
