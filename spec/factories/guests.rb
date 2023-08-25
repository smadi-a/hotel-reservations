FactoryBot.define do
  factory :guest do
    first_name { 'John' }
    last_name { 'Doe' }
    email { 'john.doe@domain.com' }
  end
end
