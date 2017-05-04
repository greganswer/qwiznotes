require "rails_helper"

feature "Home pages" do
  let(:current_user) { create(:user) }
  before(:each) { visit root_path }

  GUEST_LINKS = {
    "nav" => [
      { link: I18n.t("demo.index.link"), css: ".qa-page.demo.index" },
      { link: Note.model_name.human(count: 2), css: ".qa-page.notes.index" },
      { link: I18n.t("app.help"), css: ".qa-page.home.help" },
      { link: I18n.t("devise.registrations.new.sign_up"), css: ".qa-page.devise.registrations.new" },
      { link: I18n.t("app.sign_in"), css: ".qa-page.devise.sessions.new" },
    ],
    "footer" => [
      { link: I18n.t("demo.index.link"), css: ".qa-page.demo.index" },
      { link: I18n.t("app.help"), css: ".qa-page.home.help" },
      { link: I18n.t("legal.terms"), css: ".qa-page.legal.terms" },
      { link: I18n.t("legal.privacy"), css: ".qa-page.legal.privacy" },
      { link: I18n.t("devise.registrations.new.sign_up"), css: ".qa-page.devise.registrations.new" },
      { link: I18n.t("app.sign_in"), css: ".qa-page.devise.sessions.new" },
    ],
  }

  USER_LINKS = {
    "nav" => [
      { link: I18n.t("note.new"), css: ".qa-page.notes.new" },
      { link: Note.model_name.human(count: 2), css: ".qa-page.notes.index" },
      { link: User.model_name.human(count: 2), css: ".qa-page.users.index" },
      { link: I18n.t("app.help"), css: ".qa-page.home.help" },
      { link: I18n.t("app.account"), css: ".qa-page.devise.registrations.edit" },
      { link: I18n.t("app.sign_out"), css: ".qa-page.devise.sessions.destroy" },
    ],
    "footer" => [
      { link: I18n.t("demo.index.link"), css: ".qa-page.demo.index" },
      { link: I18n.t("app.help"), css: ".qa-page.home.help" },
      { link: I18n.t("legal.terms"), css: ".qa-page.legal.terms" },
      { link: I18n.t("legal.privacy"), css: ".qa-page.legal.privacy" },
      { link: I18n.t("app.sign_out"), css: ".qa-page.devise.sessions.destroy" },
    ],
  }

  #
  # Guest
  #

  feature "GUEST" do
    GUEST_LINKS.each do |location, items|
      items.each do |item|
        scenario "clicks #{item[:link]} link from #{location.upcase}" do
          within(location) { click_link item[:link] }
          expect(page).to have_css(item[:css])
          if location == GUEST_LINKS.first && item == location.first
            within("footer") { click_link t("app.home") }
          else
            within("nav") { click_link "site-name" }
          end
          expect(page).to have_css(".qa-page.home.index")
        end
      end
    end
  end

  #
  # User
  #

  feature "USER" do
    before(:each) { sign_in_as(current_user) }

    USER_LINKS.each do |location, items|
      items.each do |item|
        scenario "clicks #{item[:link]} link from #{location.upcase}" do
          within(location) { click_link item[:link] }
          expect(page).to have_css(item[:css]) unless item[:css].include?("destroy")
          if location == USER_LINKS.first && item == location.first
            within("footer") { click_link t("app.home") }
          else
            within("nav") { click_link "site-name" }
          end
          scope = item[:link] == I18n.t("app.sign_out") ? "home" : "notes"
          expect(page).to have_css(".qa-page.#{scope}.index")
        end
      end
    end
  end
end

