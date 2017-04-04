#
# Methods
#

def submit_note_form(title: "My new note", content: "I am so happy that I get to use this site")
  fill_in Note.human_attribute_name(:title), with: title
  fill_in Note.human_attribute_name(:content), with: content
  click_button "note-save"
end

#
# Steps
#

When(/^I click the "Create Note" button$/) do
  within("nav") { click_on I18n.t("note.new") }
end

When(/^I fill in the note form$/) do
  submit_note_form
end

When(/^I do not enter the note title$/) do
  submit_note_form(title: "")
end

When(/^I do not enter the note content$/) do
  submit_note_form(content: "")
end

Then(/^I should see that the note was created$/) do
  expect(page).to have_content(I18n.t("note.created"))
end

Then(/^I should see that the note was not created$/) do
  expect(page).to have_content(I18n.t("simple_form.error_notification.default_message"))
  expect(page).not_to have_content(I18n.t("note.created"))
end

Then(/^I should not see the "New Note" button$/) do
  expect(page).not_to have_content(I18n.t("note.new"))
end
