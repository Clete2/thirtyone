// app/assets/javascripts/app.people.js

App.People = {};

App.People.updateNewPersonButton = function(input) {
  var value = input.value;
  var add_button = $('#newperson');
  if (value != "") {
    add_button.removeClass('hide');
    add_button.addClass('button');
    add_button.val('+ Add ' + value);
  } else {
    add_button.addClass('hide');
    add_button.removeClass('button');
    add_button.html('');
  }
};

App.People.updatePersonSearch = function(input, users_only, show_new_button) {
  users_only = typeof users_only !== 'undefined';
  show_new_button = typeof show_new_button !== 'undefined';

  if ( show_new_button ) {
    App.People.updateNewPersonButton(input);
  }

  var data = {ajax: true};

  if (input.value.length > 0) {
    var search_key_array = input.value.split(" ");
    var search_keys = JSON.stringify(search_key_array);
    data['search'] = search_keys;
  }

  if ( users_only ) { data['users_only'] = 'true'; }

  var request = $.ajax({
    url: "/people/search",
    type: "GET",
    data: data,
    dataType: "html"
  });

  request.done(function (html) {
    $("#results").html(html)
  });

  request.fail(function (jqXHR, textStatus) {
    alert("Search update failed: " + textStatus);
  });
};

$(document).ready(function() {
  if (!($("body.people").length > 0)) {
    return;
  }
  // Anything here will get executed when a page is rendered through the People controller

  $("input#person_phone").inputmask("(999) 999-9999");
  $("input#person_phone_ext").inputmask("9999999999");
});
