FactoryGirl.define do
  factory :vote do
    user
    item { create(:note) }

    factory :random_vote do
      user { create(:random_user) }
      item { create(:random_note, user: create(:random_user)) }
      has_random_dates
    end
  end
end
