$(function() {
    var t;
    function size(animate){
        if (animate == undefined){
            animate = false;
        }
        clearTimeout(t);
        t = setTimeout(function(){
            $(".line_chart").each(function(){
                draw_line_chart(animate, $(this));
            });

            $(".doughnut_chart").each(function(){
                if($(this).is(":visible")){
                    draw_doughnut_chart(animate, $(this));
                }
            });

        }, 1);
    }

    function draw_doughnut_chart(animate, $this){
        var animation = get_animation(animate);
        var tmp = $this.data('chart');

        if(jQuery.isEmptyObject(tmp)){
            // Append error message if there is no data
            $this.parent().append("<h4 class=\"text-warning\">No data!</h4>");
            // Remove canvas
            $this.remove();
        }else{
            var data = [];
            for (var key in tmp) {
                data.push(tmp[key]);
            }

            let dataset = {
                data: [],
                backgroundColor: []
            }
            let labels = []

            for(var key in tmp) {
                dataset['data'].push(tmp[key]['value'])
                dataset['backgroundColor'].push(tmp[key]['color'])
                labels.push(key)
            }

            var config = {
                type: 'doughnut',
                data: {
                    datasets: [
                        dataset
                    ],
                    labels: labels,

                },
                options: {
                    legend: {
                        display: false
                    },
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: animation
                }
            }
            new Chart($this, config);
        }
    }

    function get_animation(animate){
        return {duration: animate? 1000 : 0};
    }

    function draw_line_chart(animate, $canvas){
        var animation = get_animation(animate);
        var chart_data = create_dataset($canvas);
        var weeks = $canvas.closest('.chart_data').data('weeks');
        var data = {
            labels : weeks,
            datasets : chart_data
        }

        var config = {
            type: 'line',
            data: {
                labels : weeks,
                datasets: chart_data
            },
            options: {
                legend: {
                    display: false
                },
                responsive: true,
                maintainAspectRatio: false,
                animation: animation
            }
        }

        new Chart($canvas, config);
    }

    function create_dataset($canvas){
        var selected = getSelectedConferences($canvas);
        var chart_data = $canvas.closest('.chart_data').data('chart');
        var conferences = $canvas.closest('.chart_data').data('conferences');
        var result = [];

        for(var i in conferences){
            if(selected.indexOf(conferences[i].short_title) >= 0){
                var options = {};
                options.backgroundColor = "rgba(255,255,0,0.0)";
                options.borderColor = conferences[i].color;
                options.label = conferences[i].short_title;
                options.pointBorderWidth = 3
                options.data = chart_data[conferences[i].short_title];
                if(options.data == null || options.data.length == 0){
                    options.data = [0];
                }
                result.push(options)
            }
        }
        return result
    }

    function getSelectedConferences($canvas){
        var name = $canvas.data('name');
        var id = '#' + name + 'Checkboxes'
        var selected = [];
        var $checkboxes = $(id + ' input');
        // If there are checkboxes -> get selected
        // Else -> use the active conference
        if($checkboxes.length){
            $(id + ' input').each(function(){
                if($(this).is(":checked")) {
                    selected.push($(this).attr('name'));
                }
            });
        }else{
            var active = $canvas.closest('.chart_data').data('active');
            for(i in active){
                selected.push(active[i].short_title)
            }
        }
        return selected;
    }

    $('.conferenceCheckboxes input').change(function(){
        var chart_name = $(this).parent().data('chart');
        var $canvas = $('#line_chart_' + chart_name);
        draw_line_chart(false, $canvas);
    });

    $(window).on('resize', function(){
        size(false);
    });

    $('#doughnut_tabs a').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
        size(false);
    });

    size(true);
});
