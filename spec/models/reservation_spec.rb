require 'rails_helper'

RSpec.describe Reservation, :type => :model do
  context 'validations' do
    context 'dates overlap' do
      let(:first_table) { Table.create! }
      let(:second_table) { Table.create! }
      let(:today) { Date.today }

      def time_at(hours)
        today.to_time + hours.hours
      end

      def reserve_at(range, table = first_table)
        table.reservations.new(start_time: time_at(range.first),
                               end_time: time_at(range.last))
      end

      it 'allows two reservations to co-exist' do
        reserve_at(19..20).save!
        expect(reserve_at(21..22)).to be_valid
      end

      it 'checks overlap' do
        reserve_at(19..21).save!
        expect(reserve_at(20..22)).to_not be_valid
      end
    end
  end
end
