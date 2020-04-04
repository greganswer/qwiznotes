# frozen_string_literal: true

require_relative 'seed_helper.rb'

ActionMailer::Base.perform_deliveries = false

#
# Methods
#

def create(*args)
  FactoryGirl.create(*args)
end

def create_list(*args)
  FactoryGirl.create_list(*args)
end

def create_first_user
  create(:random_user, email: 'greganswer@gmail.com', image_url: nil)
end

#
# Users
#

USER_COUNT = 4
puts "SEEDING #{USER_COUNT + 1} USERS"
users = []
users << create_first_user unless Rails.env.staging?
users += create_list(:random_user, USER_COUNT)

#
# Notes
#

NOTE_COUNT_PER_USER = 5
users.each do |user|
  puts "SEEDING #{NOTE_COUNT_PER_USER} NOTES FOR USER ##{user.id} NOTES"
  NOTE_COUNT_PER_USER.times do
    create(:random_note, user: user, content: SeedHelper.note_content.sample)
  end
end

#
# Comments
#

COMMENTS_PER_NOTE = 12
user_ids = User.ids
Note.find_each do |note|
  puts "SEEDING #{COMMENTS_PER_NOTE} COMMENTS FOR NOTE ##{note.id}"
  COMMENTS_PER_NOTE.times do
    created_at = Faker::Time.between(from: note.created_at, to: Time.current)
    create(:random_comment, user_id: user_ids.sample, item: note, created_at: created_at)
  end
end

#
# Votes
#

MAX_VOTES_PER_ITEM = 5
user_ids = User.ids
Note.find_each do |note|
  puts "SEEDING UP TO #{MAX_VOTES_PER_ITEM} VOTES FOR NOTE ##{note.id}"
  count = rand(0..MAX_VOTES_PER_ITEM)
  count.times do
    created_at = Faker::Time.between(from: note.created_at, to: Time.current)
    create(:vote, user_id: user_ids.sample, item: note, created_at: created_at)
  end
end
