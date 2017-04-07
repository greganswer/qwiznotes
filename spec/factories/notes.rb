FactoryGirl.define do
  factory :note do
    user
    sequence(:title) { |n| "Title #{n}" }
    sequence(:content) { |n| "Content #{n}" }

    factory :note_with_concepts do
      content { I18n.t('note.sample.content') }
    end

    factory :random_note do
      user { create(:random_user) }
      title { Faker::Hipster.sentence[0..68] }
      content { (1..rand(3..6)).map { Faker::Hipster.paragraph(rand(3..10)) }.join("<br><br>") }
      has_random_dates
    end
  end
end
