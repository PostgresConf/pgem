function handle_change(ev) {
    var cbs = $('tr').filter(':has(:checkbox.event-checkbox:checked)')

    cbs.addClass('selected')
    let event_ids = get_event_ids()

    $('#bulkbtn').toggleClass('disabled', event_ids.length == 0)

    if(ev) {
        $(ev.target).closest('tr').toggleClass('selected', ev.target.checked)
    }
}

function array2params(name, arr) {
    return arr.map(function(item){return name+'[]='+item}).join('&')
}

function bulkops_handler() {
    var event_ids = get_event_ids()
    if(event_ids.length > 0) {
        $.ajax({
            method: 'POST',
            url: $(this).data('href'),
            contentType: "application/json",
            data: JSON.stringify({ 'event_ids': event_ids })
        })
    }
}

function get_event_ids() {
    let nodes = $('.datatable-events').DataTable({"retrieve": true}).rows().nodes()
    let ids = []
    nodes.each(function(node) {
        let found = $(node).find('.event-checkbox:checked').data('event-id')
        if(found) {
            ids.push(found)
        }
    })
    return ids
}

function select_all(ev) {
    let nodes = $('.datatable-events').DataTable({"retrieve": true}).rows().nodes()
    nodes.each(function(node){
        $(node).find('.event-checkbox').prop('checked', ev.target.checked)
        $(node).toggleClass('selected', ev.target.checked)
    })
    handle_change();
}

$(function () {
  $('input[class="event-checkbox"]').on('click', handle_change);
  $('#select_all').on('click', select_all);
  $('#bulk_accept,#bulk_accept_silent,#bulk_confirm,#bulk_reject,#bulk_reject_silent').on('click', bulkops_handler)
});
