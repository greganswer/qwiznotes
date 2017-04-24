FactoryGirl.define do
  factory :user do
    password 'secret'
    sequence(:email) { |n| "name_#{n}@example.com" }

    factory :random_user do
      sequence(:email) { |n| "#{Faker::Internet.user_name(nil, %w(._-))}_#{n}@example.com" }
      sequence(:image_url) { |n| "https://randomuser.me/api/portraits/#{rand(2).zero? ? 'men' : 'women'}/#{n % 200}.jpg" }
      has_random_dates
    end
  end
end
