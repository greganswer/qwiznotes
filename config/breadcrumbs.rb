## HOME

crumb :root do
  link t('app.home'), root_path
end

## DEVISE

crumb :new_user_registration do
  link t('devise.registrations.new.title'), new_user_registration_path
  parent :root
end

crumb :new_user_session do
  link t('devise.sessions.new.title'), new_user_session_path
  parent :root
end

## NOTES

crumb :notes do
  link t('notes.index.link'), notes_path
  parent :root
end

crumb :note do |note|
  link note.title, note_path(note)
  parent :notes
end

crumb :new_note do
  link t('notes.new.link_title'), new_note_path
  parent :notes
end

crumb :edit_note do |note|
  link t('notes.edit.link'), edit_note_path(note)
  parent note
end

crumb :review_note do |note|
  link t('notes.review.link'), review_note_path(note)
  parent note
end

crumb :quiz_note do |note|
  link t('notes.quiz.link'), quiz_note_path(note)
  parent note
end

crumb :quiz_results_note do |note|
  link t('notes.quiz_results.title'), quiz_results_note_path(note)
  parent note
end
