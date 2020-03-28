jQuery(function() {
  var makeSortable, settings;
  settings = '.settings';
  $('.grabbable').tooltip({
    title: 'Click to make settings sortable.'
  });
  $('.accordion').click(function() {
    $('.mdi-arrows').removeClass('mdc-text-blue');
    return $(settings).sortable('disable');
  });
  $('.setting-grabber').click(function() {
    $('.multi-collapse').collapse('hide');
    $('.mdi-arrows').addClass('mdc-text-blue');
    return $(settings).sortable("enable");
  });
  makeSortable = function(sortableCollection, element) {
    $(sortableCollection).sortable({
      appendTo: element
    });
    $(sortableCollection).sortable('disable');
    return $(sortableCollection).sortable({
      axis: 'y',
      items: '.item',
      update: function(e, ui) {
        var item_id, model, position, url;
        url = e.target.getAttribute('data-update-url');
        model = e.target.getAttribute('data-model');
        item_id = ui.item.data('item-id');
        position = ui.item.index();
        return $.ajax({
          type: 'POST',
          url: url,
          dataType: 'json',
          data: {
            [`${model}`]: {
              'orderable_id': item_id,
              'row_order_position': position - 1
            }
          }
        });
      }
    });
  };
  return makeSortable(settings);
});
