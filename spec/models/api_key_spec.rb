require 'rails_helper'

RSpec.describe APIKey, type: :model do
  context 'validations' do
    it { should validate_presence_of(:key) }
    it { should_not validate_presence_of(:partner_name) }
    it { should_not validate_presence_of(:disabled) }
  end
end
