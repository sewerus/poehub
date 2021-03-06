// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require popper
//= require rails-ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

//hiding elements
function hide_element(id) {
    var obj = document.getElementById(id);
    obj.style.opacity = '0';
    obj.style['max-height'] = '0';
    window.setTimeout(
        function removethis() {
            obj.remove();
        }, 1000);
}

//toggle value for subscribe and like
function toggle_value(id) {
    var obj = $('span#' + id).first();
    var new_value = parseInt(obj.text());
    obj.empty();
    if(obj.parent().hasClass('orange-text')) {
        obj.parent().removeClass('orange-text');
        new_value = new_value - 1;
    } else {
        obj.parent().addClass('orange-text');
        new_value = new_value + 1;
    }
    obj.text(new_value);
}