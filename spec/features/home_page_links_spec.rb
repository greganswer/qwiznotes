require "rails_helper"

feature "Home pages" do
  let(:current_user) { create(:user) }
  before(:each) { visit root_path }

  GUEST_LINKS = {
    'nav' => ['notes.index', 'devise.registrations.new', 'devise.sessions.new'],
    'footer' => ['notes.index', 'devise.registrations.new', 'devise.sessions.new'],
  }.freeze

  USER_LINKS = {
    'nav' => ['notes.index', 'devise.sessions.destroy'],
    'footer' => ['notes.index', 'devise.sessions.destroy'],
  }.freeze

  ## GUEST

  feature "GUEST" do
    GUEST_LINKS.each do |location, scopes|
      scopes.each do |scope|
        scenario "clicks #{scope} link from #{location.upcase}" do
          within(location) { click_link t("#{scope}.link") }
          expect(page).to have_title(t("#{scope}.title"))
          within("nav") { click_link 'site-name' }
          expect(page).to have_title(t("marketing.tagline"))
        end
      end
    end
  end

  ## USER

  feature "USER" do
    before(:each) { sign_in_as(current_user) }

    USER_LINKS.each do |location, scopes|
      scopes.each do |scope|
        scenario "clicks #{scope} link from #{location.upcase}" do
          within(location) { click_link t("#{scope}.link") }
          if scope.include?('destroy')
            expect(page).to have_title(t("marketing.tagline"))
          else
            expect(page).to have_title(t("#{scope}.title"))
          end
          within("nav") { click_link 'site-name' }
          title_scope = scope.include?('destroy') ? "marketing.tagline" : "home.index.title"
          expect(page).to have_title(t(title_scope))
        end
      end
    end
  end
end

