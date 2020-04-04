# frozen_string_literal: true

FactoryGirl.define do
  trait :has_random_dates do
    created_at { Faker::Time.between(from: 4.years.ago, to: Time.current) }
    updated_at { rand(3).zero? ? created_at : Faker::Time.between(from: created_at, to: Time.current) }
  end
end
