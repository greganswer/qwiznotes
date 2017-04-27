require_relative "seed_helper.rb"

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
users << create_first_user if !Rails.env.staging?
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
    created_at = Faker::Time.between(note.created_at, Time.current)
    create(:random_comment, user_id: user_ids.sample, item: note, created_at: created_at)
  end
end

#
# Tags
#

all_tags = %i(math english art languages history business geography technology computer science engineering)
users.each do |user|
  tags = all_tags.sample(rand(3..5))
  user.tag_list = tags.join(', ')
  user.save
  puts %{SEEDING "#{tags.join(', ')}" TAGS FOR USER ##{user.id} NOTES}
  user.notes.find_each do |note|
    note.tag_list = tags.sample(rand(1..3)).join(', ')
    note.save
  end
end
