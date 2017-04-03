#
# Methods
#

def submit_login_form(email: @current_user.email, password: 'secret')
  fill_in User.human_attribute_name(:email), with: email
  fill_in User.human_attribute_name(:password), with: password
  click_button t('devise.sessions.new.title')
end

#
# Steps
#

Given(/^I click the "Log in" button$/) do
  within('nav') { click_on t('devise.sessions.new.title') }
end

Given(/^I have an account$/) do
  @current_user = create(:user)
end

Given(/^I am logged in$/) do
  @current_user = create(:user)
  visit new_user_session_path
  submit_login_form(email: @current_user.email)
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

When(/^I log out$/) do
  within('footer') { click_on t('devise.sessions.destroy.title') }
end

Then(/^I should see that I'm logged in$/) do
  expect(page).to have_content(t('devise.sessions.signed_in'))
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
