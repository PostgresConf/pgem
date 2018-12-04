function update_price($this){
    var id = $this.data('id');

    // Calculate price for row
    var value = $this.val();
    var price = $('#price_' + id).text();
    var row_total = accounting.formatMoney(value * price, parent.currency_symbol, 0, parent.currency_delimiter, parent.currency_separator);
    $('#total_row_' + id).text(row_total);

    // Calculate total price
    var total = 0;
    $('.total_row').each(function( index ) {
        var row_val = accounting.unformat($(this).text());
        total += parseFloat(row_val);
    });
    total = accounting.formatMoney(total, parent.currency_symbol, 0, parent.currency_delimiter, parent.currency_separator);
    $('#total_price').text(total);
}

function update_quantity(chk_bx, ticket_id){
    if(chk_bx.checked) {
        document.getElementById('tickets__' + ticket_id).value = '1';
    } else {
        document.getElementById('tickets__' + ticket_id).value = '0';
        var elems = document.querySelectorAll('input[id^="chosen_events__' + ticket_id + '_"]');
        for (var i = 0, len = elems.length; i < len; i++){
            elems[i].checked = false;
        }
    }
    document.getElementById('tickets__' + ticket_id).dispatchEvent(new Event('change'));
}

function update_event(sb, ticket_id){
	var tt = 0;
    var evs = document.querySelectorAll('*[id^="chosen_events_' + ticket_id + '_"]');
    for (var i = 0; i < evs.length; ++i) {
      tt = +tt + +evs[i].value;
    }

    document.getElementById('tickets__' + ticket_id).value = tt;
    $('#ticket_label_' + ticket_id).text(tt);

    document.getElementById('tickets__' + ticket_id).dispatchEvent(new Event('change'));
}

function save_state() {
    form_inputs = $('select')
    var input_states = []
    $.each(form_inputs, function(i, v){
        input_states.push([v.id, v.value]);
    });
    sessionStorage.setItem('input_states', JSON.stringify(input_states));
}


function restore_state () {
    var input_states = sessionStorage.getItem('input_states')
    if (input_states) {
        var parsed = JSON.parse(input_states)
        parsed.forEach(function(element) {
            $('#'+element[0]).val(element[1])
        });
        parsed.forEach(function(element) {
            $('#'+element).trigger('change');
        });
        sessionStorage.removeItem('input_states')
    }
}

$( document ).ready(function() {
    $('.quantity').each(function() {
        update_price($(this));
    });

    $('.quantity').change(function() {
        update_price($(this));
    });
    $(function () {
      $('[data-toggle="tooltip"]').tooltip();
    });

    $('#apply_code').on('click', save_state)
    restore_state();
});
