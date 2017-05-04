#
# Methods
#

def submit_comment_form(content: "I am so happy that I get to use this site")
  fill_in 'comment_content', with: @comment_content = content
  click_button "qa-comment-save"
end

#
# Steps
#

When(/^I fill in the comment form$/) do
  submit_comment_form
end

# I should see that the comment was created
# I should see that the comment was not created
Then(/^I should see that the comment was( not)? created$/) do |not_expected|
  if (not_expected)
    expect(page).to have_content(t("simple_form.error_notification.default_message"))
    expect(page).not_to have_content(t("comment.created"))
  else
    expect(page).to have_content(t("comment.created"))
    expect(page).to have_content(@comment_content)
  end
end
