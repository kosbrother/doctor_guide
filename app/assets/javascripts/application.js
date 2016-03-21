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


$(document).ready(
    function()
    {
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

        $(".recommend-lists-tag").click(make_button_active);

    //Recommend doctors tag
        $('.recommend-lists-tag').click(function (e) {
            e.preventDefault();
            $(this).tab('show')
        })
        $('span.stars').stars();
    }
);
//Show rating star
$.fn.stars = function() {
    return $(this).each(function() {
        // Get the value
        var val = parseFloat($(this).html());
        // Make sure that the value is in 0 - 5 range, multiply to get width
        var size = Math.max(0, (Math.min(5, val))) * 16;
        // Create stars holder
        var $span = $('<span />').width(size);
        $(this).before(val.toFixed(1));
        // Replace the numerical value with stars
        $(this).html($span);
    });
}
