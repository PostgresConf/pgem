$(function () {
    /**
    * Update the number of words in the biography text field every time the user
    * releases a key on the keyboard
     */
    $("#user_biography").bind('keyup', function() {
        word_count(this, 'bio_length', 150);
    } );

    /**
     * Displays a modal with the questions of the registration.
     */
    $(document).ready(function(){
        $(".question-btn").click(function(){
            var id = $(this).data('id');
            $("#question-modal-body").empty();
            $("#question-modal-body").html($(".question" + id).clone().show());
            $("#question-modal-header").text('Questions for ' + $(this).data('name'));
            $('#questions').modal('show');
        });
    });

    /**
     * Toggles email template help below email body textarea field.
     */
    $(document).ready( function() {
        $(".template-help").hide();
        $(".template_help_link").click(function() {
            var id = $(this).data('name');
            $("#" + id).toggle();
        });
    });

    $(".select-help-toggle").change(function () {
        var id = $(this).attr('id');
        $('.' + id).collapse('hide');

        $('#' + $(this).val() + '-help.' + id).collapse('show');
    });
    $('.dropdown-toggle').dropdown();

    /**
     * Adds the default template as value to the regarding email subject and body input fields.
     */
    $(".load_template").on('click', function () {
        var subject_template = $(this).data('subjecttemplate');
        var body_template = $(this).data('bodytemplate');
        var subject_input_name = $(this).data('subjectinputname');
        var body_input_name = $(this).data('bodyinputname');
        $('#' + subject_input_name).val(subject_template);
        $('#' + body_input_name).val(body_template);
    });

    /**
     * Toggle the required attribute on click on_send_email radio button.
     */
    $('.send_on_radio').click(function () {
        toggle_required_for_mail_subjects($(this))
    });

    /**
     * Adds required attribute to on_send_email radio button if necessary.
     */
    $('.send_on_radio').each(function () {
        toggle_required_for_mail_subjects($(this))
    });
    /**
     * Toggle the required attribute helper function.
     */
    function toggle_required_for_mail_subjects($this) {
        var name = $this.data('name');
        if ($this.is(':checked')) {
            $('#' + name).prop('required', true);
        } else {
            $('#' + name).removeAttr('required');
        }
    }

    /**
     /**
     * Opens a prompt with the URL to copy to clipboard.
     * Used in the campaign index view.
     */
    $('.copyLink').on('click', function(){
        var url = $(this).data('url');
        copyToClipboard(url);
    })
    function copyToClipboard(text) {
        window.prompt("Copy to clipboard: Ctrl+C, Enter", text);
    }

    /**
     * Toggles the targets on the conference site with a more / less link.
     */
    $('.show_targets').click(function () {
        if($(this).text().trim() == 'more'){
            $(this).text("less");
        }else{
            $(this).text("more");
        }
        $('#' + $(this).data('name')).toggle();
    });

    $(".comment-reply-link").click(function(){
        $(".comment-reply", $(this).parent()).toggle();
        return false;
    });

    $("#event-comment-link").click(function(){
        $("#comments-div").toggle();
        return false;
    });

    $(".comment-reply").hide();
    $(".user-details-popover").popover();
    $("#comments-div").hide();

    $('a:contains("Add track")').click(function () {
        setTimeout(function () {
                $("div.nested-fields:last div:nth-of-type(2) input").val(get_color());
            },
            5)
    });

    $('a:contains("Add difficulty_level")').click(function () {
        setTimeout(function () {
                $("div.nested-fields:last div:nth-of-type(3) input").val(get_color());
            },
            5)
    });

    $('a:contains("Add event_type")').click(function () {
        setTimeout(function () {
                $("div.nested-fields:last div:nth-of-type(5) input").val(get_color());
            },
            5)
    });
});

function get_color() {
    var colors = ['#000000', '#0000FF', '#00FF00', '#FF0000', '#FFFF00', '#9900CC',
        '#CC0066', '#00FFFF', '#FF00FF', '#C0C0C0', '#00008B', '#FFD700',
        '#FFA500', '#FF1493', '#FF00FF', '#F0FFFF', '#EE82EE', '#D2691E',
        '#C0C0C0', '#A52A2A', '#9ACD32', '#9400D3', '#8B008B', '#8B0000',
        '#87CEEB', '#808080', '#800080', '#008B8B', '#006400'
    ];
    return colors[Math.floor(Math.random() * colors.length)];
}

function word_count(text, divId, maxcount) {
    var r = 0;
    var input = text.value.replace(/\s/g,' ');
    var word_array = input.split(' ');
    for (var i=0; i < word_array.length; i++) {
        if (word_array[i].length > 0) r++;
    }

    $('#' + divId).text(r);
    if (r > maxcount) {
        $('#' + divId).css('color', 'red');
    } else {
        $('#' + divId).css('color', '#333');
    }
};

$( document ).ready(function() {
  $('#expand_archive').on('click', function (event) {
    $('.hidable').collapse('toggle')
    let label =  $('#archive_label')[0]
    label.innerText = label.innerText.includes('Show') ? 'Show Less' : 'Show More'
    return false;
  }); 
});

/* Wait for the DOM to be ready before attaching events to the elements */
$( document ).ready(function() {
    /* Set the minimum and maximum proposal abstract word length */
    $("#event_event_type_id").change(function () {
        var $selected = $("#event_event_type_id option:selected")
        var max = $selected.data("max-words");
        var min = $selected.data("min-words");

        $("#abstract-maximum-word-count").text(max);
        $("#abstract-minimum-word-count").text(min);
        word_count($('#event_abstract').get(0), 'abstract-count', max);
    })
        .trigger('change');

    /* Count the proposal abstract length */
    $("#event_abstract").bind('change keyup paste input', function() {
        var $selected = $("#event_event_type_id option:selected")
        var max = $selected.data("max-words");
        word_count(this, 'abstract-count', max);
    } );
});

/* Commodity function for modal windows */

window.build_dialog = function(selector, content) {
  // Close it and remove content if it's already open
  $("#" + selector).modal('hide');
  $("#" + selector).remove();
  // Add new content and pops it up
  $("body").append("<div id=\"" + selector + "\" class=\"modal fade\" role=\"dialog\">\n" + content + "</div>");
  $("#" + selector).modal();
}

  function url_to_params (hash) {
    var parts = hash.substring(1).split('&')
    return {
      track: parts[1] ? parts[1].split('=')[1] : '',
      day: parts[0]
    }
  }

  function params_to_url(day, track) {
    var trackpart = track ? '&' + 'track=' + track : ''
    return day + trackpart
  }
