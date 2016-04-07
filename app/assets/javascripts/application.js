// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

var ready;
ready = function() {


    //Attach events to menu
    var make_button_active = function()
    {
        //Get item siblings
        var siblings =($(this).siblings());

        //Remove active class on all buttons
        siblings.each(function (index)
            {
                $(this).removeClass('active');
            }
        );


        //Add the clicked button class
        $(this).addClass('active');
    };

    var change_link = function(){
      var a = $(this).parent().find('.recommend-lists-more > a').eq(0);
        var type = $(this).data('type');
        var value = a.data(type);
        a.attr('href', value)
    };

    $(".recommend-lists-tag").click(make_button_active);
    $(".recommend-lists-tag").click(change_link);
    //Recommend doctors tag
    $('.recommend-lists-tag').click(function (e) {
        e.preventDefault();
        $(this).tab('show');
    });

    //Show rating star
    $.fn.stars = function() {
        return $(this).each(function() {
            // Get the value
            var val = parseFloat($(this).html());
            // Make sure that the value is in 0 - 5 range, multiply to get width
            var size = Math.max(0, (Math.min(5, val))) * 16;
            // Create stars holder
            var $span = $('<span />').width(size);
            // Replace the numerical value with stars
            $(this).html($span);
        });
    };

    $('span.stars').stars();
   $('#comment_division_id').trigger('onchange');
};

$(document).ready(ready);
$(document).on('page:load', ready);
//    updateDoctor
var update_doctor = function(division_id, hospital_id){
    $.ajax({
        url: '/update_doctor',
        type: 'GET',
        data: {division_id: division_id, hospital_id: hospital_id},
        dataType: 'html',
        success: function(data){
            var list = Object.keys(JSON.parse(data)).map(function(k) { return JSON.parse(data)[k] });
            $('#comment_doctor_id option').remove();
            if (list.length > 0)
                list.forEach(function(i){
                     $('<option/>', {
                        value: i[1],
                        text: i[0]
                    }).appendTo($('#comment_doctor_id'))
                });
            else
                $('<option/>', {
                    value: '',
                    text: '暫無資料'
                }).appendTo($('#comment_doctor_id'))
        }
    })
}
