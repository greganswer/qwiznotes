require_relative "seed_helper.rb"

ActionMailer::Base.perform_deliveries = false

#
# Users
#

USER_COUNT = 4
puts "SEEDING #{USER_COUNT + 1} USERS"
users = []
users << FactoryGirl.create(:random_user, email: 'greganswer@gmail.com') if !Rails.env.staging?
users += FactoryGirl.create_list(:random_user, USER_COUNT)

#
# Notes
#

NOTE_COUNT_PER_USER = 5
users.each do |user|
  puts "SEEDING #{NOTE_COUNT_PER_USER} NOTES FOR USER ##{user.id} NOTES"
  NOTE_COUNT_PER_USER.times do
    FactoryGirl.create(:random_note, user: user, content: SeedHelper.note_content.sample)
  end
end
