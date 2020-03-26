jQuery ->

  settings = '.settings'
  $( '.grabbable' ).tooltip(title: 'Click to make settings sortable.')
  $( '.accordion' ).click ->
    $( '.mdi-arrows' ).removeClass( 'mdc-text-blue' )
    $(settings).sortable( 'disable' )

  $( '.setting-grabber' ).click ->
    $( '.multi-collapse').collapse('hide')
    $( '.mdi-arrows' ).addClass( 'mdc-text-blue' )
    $(settings).sortable( "enable" )

  makeSortable = (sortableCollection, element) ->

    $(sortableCollection).sortable(appendTo: element )
    $(sortableCollection).sortable( 'disable' )
    $(sortableCollection).sortable(
      axis: 'y'
      items: '.item'
      update: (e, ui) ->
        url = e.target.getAttribute('data-update-url')
        model = e.target.getAttribute('data-model')
        item_id = ui.item.data('item-id')
        position = ui.item.index()
        $.ajax(
          type: 'POST'
          url: url
          dataType: 'json'
          data: { "#{model}": { 'orderable_id': item_id,
          'row_order_position': (position - 1) }}))

  makeSortable( settings )


