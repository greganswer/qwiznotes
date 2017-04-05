CKEDITOR.editorConfig = function( config )
{
  config.uiColor = '#FFFFFF';
  config.toolbarLocation = 'bottom';
  config.resize_enabled = false;
  config.height = '50vh';
  config.removePlugins = 'elementspath';

  // NOTE: if you change this file, update `config/initializers/assets.rb` as well
  config.contentsCss = '/assets/ckeditor.css';

  // Toolbar groups configuration.
  config.toolbar = [
    {
      name: 'clipboard',
      groups: [ 'clipboard', 'undo',  'basicstyles', 'editing' ],
      items: ['Save', '-', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo', '-',  'Bold', 'Italic', 'Underline', '-', 'Find','Replace','-','SelectAll','-','Scayt' ]
    },
  ];
};
