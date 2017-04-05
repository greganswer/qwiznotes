CKEDITOR.editorConfig = function( config )
{
  config.uiColor = '#FFFFFF';
  config.toolbarLocation = 'bottom';
  config.resize_enabled = false;
  config.height = '50vh';
  config.removePlugins = 'elementspath';
  config.language = 'en';


  // NOTE: Update editor styling in `assets/javascripts/ckeditor/contents.css

  // Toolbar groups configuration.
  config.toolbar = [
    {
      name: 'clipboard',
      groups: [ 'clipboard', 'undo',  'basicstyles', 'editing' ],
      items: [
        'Save', '-',
        'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-',
        'Undo', 'Redo', '-',
        'Bold', 'Italic', 'Underline', '-',
        'NumberedList', 'BulletedList', '-',
        'Outdent', 'Indent', '-',
        'Find','Replace','-',
        'SelectAll','-',
        'Scayt'
        ]
    },
  ];
};
