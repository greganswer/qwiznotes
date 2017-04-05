When(/^I click on the note "Edit" button$/) do
  click_on t("button.edit"), match: :first
end

# I should see that the note was updated
# I should see that the note was not updated
Then(/^I should see that the note was( not)? updated$/) do |not_expected|
  if (not_expected)
    expect(page).to have_content(t("simple_form.error_notification.default_message"))
    expect(page).not_to have_content(t("note.updated"))
  else
    expect(page).to have_content(t("note.updated"))
  end
end

Then(/^I should not see the "Edit" button for any note$/) do
  expect(page).to have_css(".qa-notes")
  within(".qa-notes") do
    expect(page).not_to have_content(t("button.edit"))
  end
end

Then(/^I should not see the "Edit" button on the note titled "([^"]*)"$/) do |title|
  note = Note.where(title: title).first
  expect(page).to have_css("#note_#{note.id}")
  within("#note_#{note.id}") do
    expect(page).not_to have_content(t("button.edit"))
  end
end
