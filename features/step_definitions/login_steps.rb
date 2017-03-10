Given(/^I click the "Log in" button$/) do
  within('nav') { click_on I18n.t('devise.sessions.new.link') }
end

Given(/^I have an account$/) do
  @user = create(:user)
end

When(/^I log in with valid credentials$/) do
  fill_in User.human_attribute_name(:email), with: @user.email
  fill_in User.human_attribute_name(:password), with: 'secret'
  click_button I18n.t('devise.sessions.new.submit')
end

When(/^I enter the wrong password (\d+) times$/) do |count|
  count.to_i.times do
    step "I enter the wrong password"
  end
end

When(/^I enter the wrong email address$/) do
  fill_in User.human_attribute_name(:email), with: 'wrong@mail.com'
  fill_in User.human_attribute_name(:password), with: 'secret'
  click_button I18n.t('devise.sessions.new.submit')
end

When(/^I enter the wrong password$/) do
    fill_in User.human_attribute_name(:email), with: @user.email
    fill_in User.human_attribute_name(:password), with: 'wrong password'
    click_button I18n.t('devise.sessions.new.submit')
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

Then(/^I can log out$/) do
  within('nav') { click_on I18n.t('devise.sessions.destroy.link') }
  expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
end
