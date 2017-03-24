require_relative "seed_helper.rb"

ActionMailer::Base.perform_deliveries = false

first_user = FactoryGirl.create(:random_user, email: 'greganswer@gmail.com')
users = FactoryGirl.create_list(:random_user, 4) + [first_user]

users.each do |user|
  5.times do
    FactoryGirl.create(:random_note, user: user, content: SeedHelper.note_content.sample)
  end
end
