FactoryGirl.define do
  factory :note do
    title { Faker::Lorem.sentence[0..69] }
    content do
      (1..rand(3..6)).map { Faker::Lorem.paragraph(rand(3..10)) }.join("<br><br>")
    end
  end
end
