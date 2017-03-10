Given(/^a note titled "([^"]*)" was already created$/) do |title|
  @note = create(:note, title: title)
end

Given(/^(\d+) notes were already created$/) do |count|
    create_list(:note, count.to_i)
end

When(/^I click on the note titled "([^"]*)" in the notes list$/) do |title|
  within('nav') { click_on I18n.t('notes.index.link') }
  click_on title
end

When(/^I click the "Notes" button$/) do
  within('nav') { click_on I18n.t('notes.index.link') }
end

Then(/^I should see (\d+) notes$/) do |count|
  expect(page).to have_css(".note", count: count.to_i)
end

Then(/^I should see the details of the note$/) do
  expect(page).to have_content(@note.content)
end
