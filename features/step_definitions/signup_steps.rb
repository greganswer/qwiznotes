Given(/^I click the "Sign up" button$/) do
  within('nav') { click_on I18n.t('devise.registrations.new.link') }
end

When(/^I fill out the sign up form correctly$/) do
  fill_in :user_email, with: 'mjones@example.com'
  fill_in :user_password, with: 'secret'
  click_button I18n.t('devise.registrations.new.submit')
end

Then(/^I should see that I signed up successfully$/) do
  expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
end

Then(/^I should receive a confirmation email and be able to confirm my account$/) do
  step '"mjones@example.com" should receive an email'
  step 'I open the email'
  step 'I should see "confirm" in the email body'
  step 'I follow "confirm" in the email'
  step 'I should see the "' + I18n.t('devise.confirmations.confirmed') + '" message'
end
