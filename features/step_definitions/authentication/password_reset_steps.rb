Given(/^I click the "Forgot your password" button$/) do
  click_on t('devise.shared.links.password')
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

Then(/^I should receive a password reset email and be able to click the button$/) do
  step "\"#{@current_user.email}\" should receive 2 emails"
  step "I open the email with subject \"#{t('devise.mailer.reset_password_instructions.subject')}\""
  step "I should see \"#{t('devise.mailer.reset_password_instructions.description')}\" in the email body"
  step "I follow \"#{t('devise.passwords.edit.title')}\" in the email"
  expect(page).to have_title(t('devise.passwords.edit.title'))
end

Then(/^I should see that my password was reset and I'm logged in$/) do
  expect(page).to have_content(t('devise.passwords.updated'))
end

Then(/^I should see the email not found error message$/) do
  expect(page).to have_content(t('errors.messages.not_found'))
end
