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

      it 'allows to book forward' do
        reserve_at(19..20).save!
        expect(reserve_at(21..22)).to be_valid
      end

      it 'allows to book backward' do
        reserve_at(21..22).save!
        expect(reserve_at(19..20)).to be_valid
      end

      it 'checks overlap from behind' do
        reserve_at(19..21).save!
        expect(reserve_at(20..22)).to_not be_valid
      end

      it 'checks overlap from forward' do
        reserve_at(20..22).save!
        expect(reserve_at(19..21)).to_not be_valid
      end

      it 'checks interrior surround' do
        reserve_at(19..22).save!
        expect(reserve_at(20..21)).to_not be_valid
      end

      it 'checks exterrior surround' do
        reserve_at(20..21).save!
        expect(reserve_at(19..22)).to_not be_valid
      end

      it 'allows serial from backward' do
        reserve_at(19..20).save!
        expect(reserve_at(20..21)).to be_valid
      end

      it 'allows serial from forward' do
        reserve_at(19..20).save!
        expect(reserve_at(20..21)).to be_valid
      end
    end
  end
end
