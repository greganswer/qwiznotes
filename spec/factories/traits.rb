FactoryGirl.define do
  trait :has_random_dates do
    created_at { Faker::Time.between(4.years.ago, Time.current) }
    updated_at { rand(3).zero? ? created_at : Faker::Time.between(created_at, Time.current) }
  end
end
