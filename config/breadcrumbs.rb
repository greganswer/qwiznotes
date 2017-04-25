#
# Home
#

crumb :root do
  title = user_signed_in? ? t("note.my_notes") : t("app.home")
  link title, root_path
end

crumb :help do
  link t("app.help"), help_path
  parent :root
end

#
# Legal
#

crumb :terms do
  link t("legal.terms"), terms_path
  parent :root
end

crumb :privacy do
  link t("legal.privacy"), privacy_path
  parent :root
end

#
# Devise
#

args = {
  new_user_registration: "devise.registrations.new.sign_up",
  edit_user_registration: "account.update",
  new_user_password: "devise.passwords.new.forgot_your_password",
  edit_user_password: "devise.passwords.edit.change_my_password",
  new_user_confirmation: "devise.confirmations.new.resend_confirmation_instructions",
  new_user_unlock: "devise.unlocks.new.resend_unlock_instructions",
  new_user_session: "app.sign_in",
}

args.each do |route, translation|
  crumb route do
    link t(translation), send("#{route}_path")
    parent :root
  end
end

#
# Notes
#

crumb :notes do
  link Note.model_name.human(count: 2), notes_path
  parent :root
end

crumb :note do |note|
  link note.title, note_path(note)
  parent :notes
end

crumb :new_note do
  link t("app.new"), new_note_path
  parent :notes
end

crumb :edit_note do |note|
  link t("button.edit"), edit_note_path(note)
  parent note
end

crumb :review_note do |note|
  link t("app.review"), review_note_path(note)
  parent note
end

crumb :quiz_note do |note|
  link Quiz.model_name.human, quiz_note_path(note)
  parent note
end

crumb :quiz_results_note do |note|
  link t("app.results"), quiz_results_note_path(note)
  parent :quiz_note, note
end

#
# Users
#

crumb :users do
  link User.model_name.human(count: 2), users_path
  parent :root
end

crumb :user do |user|
  link user.name, user_path(user)
  parent :users
end
