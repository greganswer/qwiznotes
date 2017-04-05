require_relative "seed_helper.rb"

ActionMailer::Base.perform_deliveries = false

users = []
users < FactoryGirl.create(:random_user, email: 'greganswer@gmail.com') if !Rails.env.staging?
users << FactoryGirl.create_list(:random_user, 4)

users.each do |user|
  5.times do
    FactoryGirl.create(:random_note, user: user, content: SeedHelper.note_content.sample)
  end
end
