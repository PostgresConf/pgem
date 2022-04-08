$(function () {
  $(document).ready(function() {

    function switchChangeHandler(event, state) {
      let url = $(this).attr('url') + state;
      let method = $(this).attr('method');
      $.ajax({
        url: url,
        type: method,
        dataType: 'script'
      });
    }

    $('.datatable').DataTable({
      stateSave: true,
      autoWidth: false,
      pagingType: 'full_numbers',
      'lengthMenu': [[25, 50, 100, -1], [25, 50, 100, "All"]]
    });

    $('.datatable-events').DataTable({
      stateSave: true,
      autoWidth: false,
      pagingType: 'full_numbers',
      'lengthMenu': [[25, 50, 100, -1], [25, 50, 100, "All"]],
      // initialize bs switch on each page draw,
      'lengthMenu': function() {
        $("[class='event-switch-checkbox']").bootstrapSwitch();
        $("input[class='event-switch-checkbox']").on('switchChange.bootstrapSwitch', switchChangeHandler);
      }
    });

    $('.datatable-users').DataTable({
      ajax: $('.datatable-users').data('source'),
      serverSide: true,
      stateSave: true,
      autoWidth: true,
      processing: true,
      pagingType: 'full_numbers',
      "lengthMenu": [[25, 50, 100, 250], [25, 50, 100, 250]],
      "fnDrawCallback": function() {
        $("[class='switch-checkbox']").bootstrapSwitch();

        $('input[class="switch-checkbox"]').on('switchChange.bootstrapSwitch', switchChangeHandler);
      },
      columns: [
        {data: 'id'},
        {data: 'confirmed', 'searchable': false, 'orderable': false },
        {data: 'email'},
        {data: 'name'},
        {data: 'roles'},
        {data: 'dt_action_view', 'searchable': false, 'orderable': false },
        {data: 'dt_action_edit', 'searchable': false, 'orderable': false },
      ]
    });

    $('#versionstable').DataTable({
      pagingType: 'full_numbers',
      autoWidth: true,
      order: [[ 0, 'desc' ]]
    });
  });
});
