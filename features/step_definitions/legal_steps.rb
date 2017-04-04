When(/^I click the "Terms of service" link$/) do
  click_on(I18n.t("legal.terms"), match: :first)
end

When(/^I click the "Privacy policy" link$/) do
  click_on(I18n.t("legal.privacy"), match: :first)
end

Then(/^I should see the "Terms of service" page$/) do
  expect(page).to have_css(".qa-page.legal.terms")
end

Then(/^I should see the "Privacy policy" page$/) do
  expect(page).to have_css(".qa-page.legal.privacy")
end
