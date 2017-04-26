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

Given(/^I see the "Agree to our terms and privacy" text$/) do
  expect(page).to have_css(".qa-you_agree_to_our_terms_and_privacy_html")
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

Then(/^I should receive a confirmation email and be able to confirm my account$/) do
  step "\"mjones@example.com\" should receive an email"
  step "I open the email"
  step "I should see \"confirm\" in the email body"
  step "I follow \"confirm\" in the email"
  expect(page).to have_content(t("devise.confirmations.confirmed"))
end

# I should see that I am signed up
# I should see that I am not signed up
Then(/^I should see that I am( not)? signed up$/) do |not_expected|
  if (not_expected)
    step "I should see that I am not logged in"
    expect(page).to have_content(t("simple_form.error_notification.default_message"))
  else
    expect(page.current_path).to eq(notes_path)
    expect(page).to have_content(t("devise.registrations.signed_up"))
  end
end
