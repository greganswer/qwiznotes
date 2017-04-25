#
# Methods
#

def submit_contact_form(with_email: true)
  fill_in 'contact_form_email', with: "name@example.com" if with_email
  fill_in 'contact_form_message', with:  "Thank you for making this site"
  click_button "qa-home-save"
end

#
# Steps
#

When(/^I click the "Help" button$/) do
  within("nav") { click_on t("app.help") }
end

When(/^I fill in the contact form$/) do
  submit_contact_form
end

When(/^I fill in the message field of the contact form$/) do
  submit_contact_form(with_email: false)
end

Then(/^I should see that the contact message was sent$/) do
  expect(page).to have_content(t("contact.message_sent"))
  step %{"#{site_email}" should receive an email}
  step "I open the email"
  step %{I should see "Thank you for making this site" in the email body}
end
