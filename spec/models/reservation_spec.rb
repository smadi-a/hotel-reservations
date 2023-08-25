require 'rails_helper'

RSpec.describe Reservation, type: :model do
  subject { create(:reservation, adults: 2) }

  context 'associations' do
    it { should belong_to(:guest) }
  end

  context 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
    it { should validate_presence_of(:adults) }
    it { should validate_numericality_of(:adults).is_greater_than(0) }
    it { should validate_presence_of(:children) }
    it { should validate_numericality_of(:children).is_greater_than(-1) }
    it { should validate_presence_of(:infants) }
    it { should validate_numericality_of(:infants).is_greater_than(-1) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:host_currency) }
  end

  context 'custom validations' do
    context 'when end_date is smaller than start_date' do
      let(:invalid_reservation) { build(:reservation, adults: 1, start_date: 2.days.from_now, end_date: 10.days.ago) }

      it 'returns a validation error' do
        expect(invalid_reservation.valid?).to be_falsey
        expect(invalid_reservation.errors.full_messages).to include('End date must be the same as or come after the start date')
      end
    end
  end
end
