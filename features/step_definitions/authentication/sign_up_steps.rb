#
# Methods
#

def submit_sign_up_form(email: "mjones@example.com", password: "secret")
  fill_in User.human_attribute_name(:email), with: email
  fill_in User.human_attribute_name(:password), with: password
  click_button t("devise.registrations.new.sign_up")
end

#
# Steps
#

Given(/^I click the "Sign up" button$/) do
  within("nav") { click_on t("devise.registrations.new.sign_up") }
end

When(/^I fill out the sign up form correctly$/) do
  submit_sign_up_form
end

When(/^I leave the email address blank$/) do
  submit_sign_up_form(email: "")
end

When(/^I leave the password blank$/) do
  submit_sign_up_form(password: "")
end

Then(/^I should see that I signed up successfully$/) do
  expect(page.current_path).to eq(root_path)
  expect(page).to have_content(t("devise.registrations.signed_up"))
end

Then(/^I should receive a confirmation email and be able to confirm my account$/) do
  step "\"mjones@example.com\" should receive an email"
  step "I open the email"
  step "I should see \"confirm\" in the email body"
  step "I follow \"confirm\" in the email"
  expect(page).to have_content(t("devise.confirmations.confirmed"))
end

Then(/^I should see that I am not signed up$/) do
  expect(page).to have_content(t("simple_form.error_notification.default_message"))
  step "I should see that I am not logged in"
end
