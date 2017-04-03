require "rails_helper"

feature "Home pages" do
  let(:current_user) { create(:user) }
  before(:each) { visit root_path }

  GUEST_LINKS = {
    'nav' => [
      { link: Note.model_name.human(count: 2), page_translation_scope: 'notes.index' },
      { link: I18n.t('devise.registrations.new.title'), page_translation_scope: 'devise.registrations.new' },
      { link: I18n.t('devise.sessions.new.title'), page_translation_scope: 'devise.sessions.new' },
    ],
    'footer' => [
      { link: Note.model_name.human(count: 2), page_translation_scope: 'notes.index' },
      { link: I18n.t('devise.registrations.new.title'), page_translation_scope: 'devise.registrations.new' },
      { link: I18n.t('devise.sessions.new.title'), page_translation_scope: 'devise.sessions.new' },
    ],
  }

  USER_LINKS = {
    'nav' => [
      { link: I18n.t('note.new.title'), page_translation_scope: 'notes.new' },
      { link: Note.model_name.human(count: 2), page_translation_scope: 'notes.index' },
      { link: I18n.t('devise.sessions.destroy.title'), page_translation_scope: 'devise.sessions.destroy' },
    ],
    'footer' => [
      { link: I18n.t('note.new.title'), page_translation_scope: 'notes.new' },
      { link: Note.model_name.human(count: 2), page_translation_scope: 'notes.index' },
      { link: I18n.t('devise.sessions.destroy.title'), page_translation_scope: 'devise.sessions.destroy' },
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
          expect(page).to have_title(t("#{item[:page_translation_scope]}.title"))
          if location == GUEST_LINKS.first && item == location.first
            within("footer") { click_link t('app.home') }
          else
            within("nav") { click_link 'site-name' }
          end
          expect(page).to have_title(t("marketing.tagline"))
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
          title_scope = item[:page_translation_scope].include?('destroy') ? "marketing.tagline" : "#{item[:page_translation_scope]}.title"
          expect(page).to have_title(t(title_scope))
          if location == USER_LINKS.first && item == location.first
            within("footer") { click_link t('app.home') }
          else
            within("nav") { click_link 'site-name' }
          end
          title_scope = item[:page_translation_scope].include?('destroy') ? "marketing.tagline" : "home.index.title"
          expect(page).to have_title(t(title_scope))
        end
      end
    end
  end
end

