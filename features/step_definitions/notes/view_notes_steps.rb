 include ActionView::Helpers::SanitizeHelper

Given(/^a note titled "([^"]*)" was already created$/) do |title|
  @note = create(:note_with_concepts, title: title)
end

Given(/^(\d+) notes were already created$/) do |count|
    create_list(:note, count)
end

Given(/^I created a note titled "([^"]*)"$/) do |title|
  @current_user.id
  @my_note = create(:note, title: title, user: @current_user)
end

When(/^I click on the note titled "([^"]*)" in the notes list$/) do |title|
  within("nav") { click_on Note.model_name.human(count: 2) }
  click_on title, match: :first
end

When(/^I click the "Notes" button$/) do
  within("nav") { click_on Note.model_name.human(count: 2) }
end

Then(/^I should see (\d+) notes$/) do |count|
  # multiply count * 2 because the table view is hidden and displayed using javascript
  expect(page).to have_css(".note", count: count * 2)
end

Then(/^I should see the details of the note$/) do
  expect(page).to have_content(html_unescape(@note.content))
end
