crumb :root do
  link t('app.home'), root_path
end

crumb :notes do
  link t('notes.index.link'), notes_path
  parent :root
end
