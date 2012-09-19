# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'example@example.com'
    password 'please'
    password_confirmation 'please'
    # required if the Devise Confirmable module is used
    confirmed_at Time.now
  end
end

FactoryGirl.define do
  factory :user2, :class => :user do
    name 'Second User'
    email 'second@eample.com'
    password 'second'
    password_confirmation 'second'
    confirmed_at Time.now
  end
end