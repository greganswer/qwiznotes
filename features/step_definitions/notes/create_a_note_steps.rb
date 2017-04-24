#
# Methods
#

def submit_note_form(title: "My new note", content: "I am so happy that I get to use this site")
  fill_in 'note_title', with: title
  fill_in_tinymce 'note_content', with: content
  click_button "qa-note-save"
end

#
# Steps
#

When(/^I click the "New Note" button$/) do
  within("nav") { click_on t("note.new") }
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

# I should see that the note was created
# I should see that the note was not created
Then(/^I should see that the note was( not)? created$/) do |not_expected|
  if (not_expected)
    expect(page).to have_content(t("simple_form.error_notification.default_message"))
    expect(page).not_to have_content(t("note.created"))
  else
    expect(page).to have_content(t("note.created"))
  end
end

Then(/^I should not see the "New Note" button$/) do
  expect(page).not_to have_content(t("note.new"))
end
