FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "#{Faker::Internet.user_name(nil, %w(_ -))}_#{n}" }
    password 'secret'
    sequence(:email) { |n| "#{name.gsub(/@| /, '')}_#{n}@example.com" }
  end
end
