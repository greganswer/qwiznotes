When(/^I click the "Quiz" button$/) do
  click_on Quiz.model_name.human, match: :first
end

When(/^I click on the "Review" button$/) do
  click_on(I18n.t("app.review"), match: :first)
end

When(/^I select some answers and submit the quiz$/) do
  choose "quiz_1_A"
  choose "quiz_2_A"
  choose "quiz_3_A"
  click_button "quiz-submit"
end

Then(/^I should see a review table for the note$/) do
  expect(page).to have_css(".review-table")
end

Then(/^I should see a quiz for the note$/) do
  expect(page).to have_field("user_answers[1]")
end

Then(/^I should see the quiz results$/) do
  expect(page).to have_css("#results-percentage")
end
