// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require jquery-ui
//= require jquery.inputmask
//= require init
//= require app.household
//= require app.people
//= require app.local_resources
//= require app.visits
//= require inventory_items
//= require app.work_schedule.js
//= require app.calendar.js
//= require validatejs

function remove_fields(link) {
    $(link).prev("input[type=hidden]").val("1");
    $(link).closest(".fields").hide();
}

function add_fields(link, association, content, parent_selector) {
    if ( parent_selector != null ) {
        parent = $(parent_selector);
    } else {
        parent = $(link).parent().parent();
    }
    var new_id = new Date().getTime();
    var regexp = new RegExp("new_" + association, "g")
    $(parent).append(content.replace(regexp, new_id));
}

$(function () {
    $('.center-vertical').each(function (index) {
        var row = $(this).closest('.row');
        $(this).height($(row).height());
    });
});