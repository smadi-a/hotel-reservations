FactoryBot.define do
  factory :reservation do
    association :guest, strategy: :create
    code { 'AJKUSH282' }
    start_date { Date.today }
    end_date { 2.days.from_now }
    status { 'accepted' }
    host_currency { 'AUD' }
  end
end
