## METHODS

def submit_login_form(email: @user.email, password: 'secret')
  fill_in User.human_attribute_name(:email), with: email
  fill_in User.human_attribute_name(:password), with: password
  click_button I18n.t('devise.sessions.new.submit')
end

def submit_sign_up_form(email: 'mjones@example.com', password: 'secret')
  fill_in User.human_attribute_name(:email), with: email
  fill_in User.human_attribute_name(:password), with: password
  click_button I18n.t('devise.registrations.new.submit')
end

## STEPS

Given(/^I click the "Sign up" button$/) do
  within('nav') { click_on I18n.t('devise.registrations.new.link') }
end

Given(/^I am logged in$/) do
  @current_user = create(:user)
  visit new_user_session_path
  submit_login_form(email: @current_user.email)
end

Given(/^I click the "Log in" button$/) do
  within('nav') { click_on I18n.t('devise.sessions.new.link') }
end

Given(/^I have an account$/) do
  @user = create(:user)
end

Given(/^another user signed up$/) do
  @user = create(:user)
end

Given(/^I see the "Log in to view mentors" message and I click it$/) do
  visit root_path
  expect(page).to have_css('.please_login_message')
  click_link 'login-link'
end

When(/^I fill out the sign up form correctly$/) do
  submit_sign_up_form
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
  within('footer') { click_on I18n.t('devise.sessions.destroy.link') }
end

Then(/^I should see that I signed up successfully$/) do
  expect(page.current_path).to eq(root_path)
  expect(page).to have_content(I18n.t('devise.registrations.signed_up'))
end

Then(/^I should receive a confirmation email and be able to confirm my account$/) do
  step '"mjones@example.com" should receive an email'
  step 'I open the email'
  step 'I should see "confirm" in the email body'
  step 'I follow "confirm" in the email'
  expect(page).to have_content(I18n.t('devise.confirmations.confirmed'))
end

Then(/^I should see that I'm logged in$/) do
  expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
end

Then(/^I should see that I'm not logged in$/) do
  expect(page).to have_content(I18n.t('devise.sessions.new.link'))
  expect(page).not_to have_content(I18n.t('devise.sessions.destroy.link'))
end

Then(/^I should see that I've been locked out$/) do
  expect(page).to have_content(I18n.t('devise.failure.locked'))
end

Then(/^I should be able to log out$/) do
  within('footer') { click_on I18n.t('devise.sessions.destroy.link') }
  expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
end

Then(/^I should see some users$/) do
  expect(page).to have_css('.users')
end

Then(/^I should see that I'm not signed up$/) do
  expect(page).to have_content(I18n.t('simple_form.error_notification.default_message'))
  step "I should see that I'm not logged in"
end
