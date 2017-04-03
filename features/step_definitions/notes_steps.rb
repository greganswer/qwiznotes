include ActionView::Helpers::SanitizeHelper

## METHODS

def submit_note_form(title: 'My new note', content: 'I am so happy that I get to use this site')
  fill_in Note.human_attribute_name(:title), with: title
  fill_in Note.human_attribute_name(:content), with: content
  click_button 'note-save'
end

## STEPS

Given(/^a note titled "([^"]*)" was already created$/) do |title|
  @note = create(:note, title: title)
end

Given(/^(\d+) notes were already created$/) do |count|
    create_list(:note, count.to_i)
end

Given(/^I created a note titled "([^"]*)"$/) do |title|
  @current_user.id
  @my_note = create(:note, title: title, user: @current_user)
end

When(/^I click on the note titled "([^"]*)" in the notes list$/) do |title|
  within('nav') { click_on Note.model_name.human(count: 2) }
  click_on title
end

When(/^I click the "Notes" button$/) do
  within('nav') { click_on Note.model_name.human(count: 2) }
end

When(/^I click the "Quiz" button$/) do
  click_on Quiz.model_name.human, match: :first
end

When(/^I click the "Create Note" button$/) do
  within('nav') { click_on I18n.t('note.new.title') }
end

When(/^I fill in the note form$/) do
  submit_note_form
end

When(/^I do not enter the note title$/) do
  submit_note_form(title: '')
end

When(/^I do not enter the note content$/) do
  submit_note_form(content: '')
end

When(/^I click on the "Review" button$/) do
  click_on(I18n.t('app.review'), match: :first)
end

When(/^I select some answers and submit the quiz$/) do
  choose "quiz_1_A"
  choose "quiz_2_A"
  choose "quiz_3_A"
  click_button "quiz-submit"
end

Then(/^I should see (\d+) notes$/) do |count|
  expect(page).to have_css(".note", count: count.to_i)
end

Then(/^I should see the details of the note$/) do
  expect(page).to have_content(html_unescape(@note.content))
end

Then(/^I should see that the note was created$/) do
  expect(page).to have_content(I18n.t('note.create.success_message'))
end

Then(/^I should see that the note was not created$/) do
  expect(page).to have_content(I18n.t('simple_form.error_notification.default_message'))
  expect(page).not_to have_content(I18n.t('note.create.success_message'))
end

Then(/^I should not see the "Create Note" button$/) do
  expect(page).not_to have_content(I18n.t('note.new.title'))
end

Then(/^I should see a review table for the note$/) do
  expect(page).to have_css('.review-table')
end

Then(/^I should see a quiz for the note$/) do
  expect(page).to have_field("user_answers[1]")
end

Then(/^I should see the quiz results$/) do
  expect(page).to have_css('#results-percentage')
end
