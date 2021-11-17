$(function () {
  $(document).ready(function() {
    $('.datatable').DataTable({
      // ajax: ...,
      stateSave: true,
      autoWidth: false,
      pagingType: 'full_numbers',
      "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]]
    });

    $('.datatable-events').DataTable({
      // ajax: ...,
      stateSave: true,
      autoWidth: false,
      pagingType: 'full_numbers',
      "lengthMenu": [[25, 50, 100, -1], [25, 50, 100, "All"]],
      // initialize bs switch on each page draw,
      "fnDrawCallback": function() {
        console.log('draw')
        $("[class='event-switch-checkbox']").bootstrapSwitch();

        $('input[class="event-switch-checkbox"]').on('switchChange.bootstrapSwitch', function(event, state) {
          var url = $(this).attr('url') + state;
          var method = $(this).attr('method');

          $.ajax({
            url: url,
            type: method,
            dataType: 'script'
          });
        });
      }
    });

    $('#versionstable').DataTable({
      pagingType: 'full_numbers',
      order: [[ 0, 'desc' ]]
    });
  });
});
