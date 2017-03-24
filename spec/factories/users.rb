FactoryGirl.define do
  factory :user do
    password 'secret'
    sequence(:email) { |n| "name_#{n}@example.com" }

    factory :random_user do
      sequence(:name) { |n| "#{Faker::Internet.user_name(nil, %w(_ -))}_#{n}" }
      sequence(:email) { |n| "#{name.gsub(/@| /, '')}_#{n}@example.com" }
      has_random_dates
    end
  end
end
