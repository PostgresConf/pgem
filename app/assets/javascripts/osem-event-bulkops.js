function event_click(el) {
    var cbs = $('tr').filter(':has(:checkbox#selected_event:checked)')

    cbs.addClass('event-row-selected')

    $('#bulkbtn').toggleClass('disabled', cbs.length == 0)

    if(el) {
        $(el).closest('tr').toggleClass('event-row-selected', el.checked)
    }
}

function array2params(name, arr) {
    return arr.map(function(item){return name+'[]='+item}).join('&')
}

function bulkops_handler() {
    var event_ids = $('#selected_event:checked').map(function(){return $(this).attr('data-event-id')}).get()
    if(event_ids.length > 0) {
        $(this).attr('href', function(i,href){ return href + '&' + array2params('event_ids', event_ids)})
    }
}

$(function () {
  event_click();
  $('input[class="event-checkbox"]').on('click', event_click);
  $('#bulk_accept,#bulk_confirm,#bulk_reject').on('click', bulkops_handler)
});
