#
# Home
#

crumb :root do
  title = user_signed_in? ? t('notes.my_notes') : t('app.home')
  link title, root_path
end

#
# Devise
#

args = {
  new_user_registration: 'devise.registrations.new.title',
  edit_user_registration: 'devise.registrations.edit.title',
  new_user_password: 'devise.passwords.new.title',
  edit_user_password: 'devise.passwords.edit.title',
  new_user_confirmation: 'devise.confirmations.new.title',
  new_user_unlock: 'devise.unlocks.new.title',
  new_user_session: 'devise.sessions.new.title',
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
  link t('app.new'), new_note_path
  parent :notes
end

crumb :edit_note do |note|
  link t('buttons.edit'), edit_note_path(note)
  parent note
end

crumb :review_note do |note|
  link t('app.review'), review_note_path(note)
  parent note
end

crumb :quiz_note do |note|
  link Quiz.model_name.human, quiz_note_path(note)
  parent note
end

crumb :quiz_results_note do |note|
  link t('app.results'), quiz_results_note_path(note)
  parent :quiz_note, note
end
