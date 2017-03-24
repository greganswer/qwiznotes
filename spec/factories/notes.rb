FactoryGirl.define do
  factory :note do
    user
    sequence(:title) { |n| "Title #{n}" }
    content "Apple - a fruit"

    factory :random_note do
      title { Faker::Hipster.sentence[0..69] }
      content { (1..rand(3..6)).map { Faker::Hipster.paragraph(rand(3..10)) }.join("<br><br>") }
      has_random_dates
    end
  end
end
