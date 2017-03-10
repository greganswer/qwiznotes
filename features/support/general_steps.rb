Given("I'm on the home page") do
  visit root_path
end

# Given(/^I see (\d+) (.*?) items$/) do |n, plural_name|
#   class_name = plural_name.singularize.parameterize.underscore
#   expect(page).to have_css(".#{class_name}", count: n.to_i)
# end

# Given(/(\d+) (.*?) were already created/) do |n, plural_name|
#   create_list(plural_name.singularize, n.to_i)
# end

# Given(/I click on the "(.*?)" link/) do |link_title|
#   click_on link_title
# end

Then(/^I should see the "([^"]*)" message$/) do |message|
  expect(page).to have_content(message)
end

