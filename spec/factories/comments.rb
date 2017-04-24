FactoryGirl.define do
  factory :comment do
    user
    item { create(:note) }
    sequence(:content) { |n| "Content #{n}" }

    factory :random_comment do
      user { create(:random_user) }
      content { Faker::Hipster.paragraph(rand(1..3)) }
      has_random_dates
    end
  end
end
