## METHODS

def submit_login_form(email: @current_user.email, password: 'secret')
  fill_in User.human_attribute_name(:email), with: email
  fill_in User.human_attribute_name(:password), with: password
  click_button t('devise.sessions.new.title')
end

def submit_sign_up_form(email: 'mjones@example.com', password: 'secret')
  fill_in User.human_attribute_name(:email), with: email
  fill_in User.human_attribute_name(:password), with: password
  click_button t('devise.registrations.new.title')
end

## STEPS

Given(/^I click the "Sign up" button$/) do
  within('nav') { click_on t('devise.registrations.new.title') }
end

Given(/^I am logged in$/) do
  @current_user = create(:user)
  visit new_user_session_path
  submit_login_form(email: @current_user.email)
end

Given(/^I click the "Log in" button$/) do
  within('nav') { click_on t('devise.sessions.new.title') }
end

Given(/^I have an account$/) do
  @current_user = create(:user)
end

Given(/^another user signed up$/) do
  @user = create(:user)
end

Given(/^I click the "Forgot your password" button$/) do
  click_on t('devise.shared.links.password')
end

When(/^I fill out the sign up form correctly$/) do
  submit_sign_up_form
end

When(/^I fill out the send password instructions form correctly$/) do
  fill_in User.human_attribute_name(:email), with: @current_user.email
  click_button t('devise.passwords.new.title')
end

When(/^I fill out the send password instructions form incorrectly$/) do
  fill_in User.human_attribute_name(:email), with: 'wrong@mail.com'
  click_button t('devise.passwords.new.title')
end

When(/^I fill out the password update form correctly$/) do
  fill_in t('attributes.new_password'), with: 'newpassword'
  fill_in t('attributes.password_confirmation'), with: 'newpassword'
  click_button t('devise.passwords.edit.title')
end

When(/^I fill out the password update form incorrectly$/) do
  fill_in t('attributes.new_password'), with: ''
  fill_in t('attributes.password_confirmation'), with: ''
  click_button t('devise.passwords.edit.title')
  expect(page).to have_content(t('errors.messages.blank'))

  fill_in t('attributes.new_password'), with: 'newpassword'
  fill_in t('attributes.password_confirmation'), with: ''
  click_button t('devise.passwords.edit.title')
  expect(page).to have_content(t('errors.messages.confirmation', attribute: t('attributes.password')))
end

When(/^I log in with valid credentials$/) do
  submit_login_form
end

When(/^I enter the wrong password (\d+) times$/) do |count|
  count.times { step "I enter the wrong password" }
end

When(/^I enter the wrong email address$/) do
  submit_login_form(email: 'wrong@mail.com')
end

When(/^I enter the wrong password$/) do
  submit_login_form(password: 'wrong password')
end

When(/^I leave the email address blank$/) do
  submit_sign_up_form(email: '')
end

When(/^I leave the password blank$/) do
  submit_sign_up_form(password: '')
end

When(/^I log out$/) do
  within('footer') { click_on t('devise.sessions.destroy.title') }
end

Then(/^I should see that I signed up successfully$/) do
  expect(page.current_path).to eq(root_path)
  expect(page).to have_content(t('devise.registrations.signed_up'))
end

Then(/^I should receive a confirmation email and be able to confirm my account$/) do
  step '"mjones@example.com" should receive an email'
  step 'I open the email'
  step 'I should see "confirm" in the email body'
  step 'I follow "confirm" in the email'
  expect(page).to have_content(t('devise.confirmations.confirmed'))
end

Then(/^I should receive a password reset email and be able to click the button$/) do
  step "\"#{@current_user.email}\" should receive 2 emails"
  step "I open the email with subject \"#{t('devise.mailer.reset_password_instructions.subject')}\""
  step "I should see \"#{t('devise.mailer.reset_password_instructions.description')}\" in the email body"
  step "I follow \"#{t('devise.passwords.edit.title')}\" in the email"
  expect(page).to have_title(t('devise.passwords.edit.title'))
end

Then(/^I should see that I'm logged in$/) do
  expect(page).to have_content(t('devise.sessions.signed_in'))
end

Then(/^I should see the email not found error message$/) do
  expect(page).to have_content(t('errors.messages.not_found'))
end

Then(/^I should see that my password was reset and I'm logged in$/) do
  expect(page).to have_content(t('devise.passwords.updated'))
end

Then(/^I should see that I'm not logged in$/) do
  expect(page).to have_content(t('devise.sessions.new.title'))
  expect(page).not_to have_content(t('devise.sessions.destroy.title'))
end

Then(/^I should see that I've been locked out$/) do
  expect(page).to have_content(t('devise.failure.locked'))
end

Then(/^I should be able to log out$/) do
  within('footer') { click_on t('devise.sessions.destroy.title') }
  expect(page).to have_content(t('devise.sessions.signed_out'))
end

Then(/^I should see some users$/) do
  expect(page).to have_css('.users')
end

Then(/^I should see that I'm not signed up$/) do
  expect(page).to have_content(t('simple_form.error_notification.default_message'))
  step "I should see that I'm not logged in"
end
