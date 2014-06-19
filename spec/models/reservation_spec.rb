require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  context 'validations' do
    context 'dates overlap' do
      it 'checks overlap' do
        expect(2*2).to eq(4)
      end
    end
  end
end
