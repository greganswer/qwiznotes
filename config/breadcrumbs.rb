crumb :root do
  link t('app.home'), root_path
end

crumb :notes do
  link t('notes.index.link'), notes_path
  parent :root
end

crumb :note do |note|
  link note.title, note_path(note)
  parent :notes
end
