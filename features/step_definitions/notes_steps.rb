When "I click on Notes" do
  within('nav') { click_on "Notes" }
end

Given /a note titled (.*?) was already created/ do |title|
  @note = create(:note, title: title)
end

Given "no notes were created yet" do
  # Note.all.destroy
end

Then "I see the details of the note" do
  expect(page).to have_content(@note.content)
end
