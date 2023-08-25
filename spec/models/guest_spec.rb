require 'rails_helper'

RSpec.describe Guest, type: :model do
  context 'associations' do
    it { should have_many(:reservations).dependent(:destroy) }
  end

  context 'validations' do
    subject { create(:guest, email: 'test@domain.com') }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end
end
