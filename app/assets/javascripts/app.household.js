// app/assets/javascripts/app.household.js

App.Household = {};

App.Household.updateHouseholdSearch = function(input) {
  var request;
  if(input.value.length > 0){
    var search_key_array = input.value.split(" ");
    var search_keys = JSON.stringify(search_key_array);

    request = $.ajax({
      url: "/households/search",
      type: "GET",
      data: { search : search_keys,
        ajax   : true },
      dataType: "html"
    });

    request.done(function( html ) {
      $( "#household_results" ).html( html );
    });

    request.fail(function( jqXHR, textStatus ) {
      alert( "Search update failed: " + textStatus );
    });
  }
  else{
    request = $.ajax({
      url: "/households/search",
      type: "GET",
      data: { ajax   : true },
      dataType: "html"
    });

    request.done(function( html ) {
      $( "#household_results" ).html( html );
    });

    request.fail(function( jqXHR, textStatus ) {
      alert( "Search update failed: " + textStatus );
    });

  }
};

App.Household.selectHousehold = function(row, url) {
  var household_id = $(row).find('input[name=household_id]').val();
  //var url = base_url + "/" + household_id;
  $.ajax({url: url,
    data: {ajax: true}
  }).fail(function( jqXHR, textStatus, errorThrown ) {
      alert("Sorry, a failure occurred");
    })
    .done(function(data, status, xhr) {
      $('#selectHouseholdModal').foundation('reveal', 'close');
      $('#household_div').html(data);
      $('#select_household_message').hide();
    });
};

App.Household.newHouseholdAjax = function(url) {
  $.ajax({url: url,
    data: {ajax: true}
  }).fail(function( jqXHR, textStatus, errorThrown ) {
      alert("Sorry, a failure occurred");
    })
    .done(function(data, status, xhr) {
      $('#selectHouseholdModal').foundation('reveal', 'close');
      $('#household_div').html(data);
      $('#select_household_message').hide();
      $("input#address_zip").inputmask("99999");
    });
};

App.Household.mergeMemberChecked = function(checkbox) {
    var parent      = $(checkbox).closest('.member-wrap')
    var deleted     = $(parent).find(".deleted");
    var member_name = $(parent).find(".member-name")
    var person_id   = $(checkbox).val();
    var all_heads   = $("input[name='head_id']");
    var head_radio  = $(all_heads).filter("[value='" + person_id + "']");
    var head_row    = $(head_radio).closest('.row');

    if ( checkbox.checked ) {
        $(member_name).removeClass("red-text");
        $(deleted).hide();
        $(head_row).show();
    } else {
        /* If the member that was selected for deletion is the currently selected
           head of household we need to verify that this is at least one other member
           eligible for being the head of household and select the first we find, or send
           the user an error telling them they cannot delete the last member of a household
         */
        if ( $(head_radio).prop('checked') ) {
            $(all_heads).each(function (index, obj) {
               if ( $(obj).val() != person_id && $(obj).is(":visible") ) {
                   $(obj).prop('checked', true);
                   return false;
               }
            });
            /* We == 1 here because we haven't hidden the last head of household yet, which would mean
               the total visible would == 0 if we let this go through */
            if ( $(all_heads).filter(":visible").length == 1 ) {
                alert("You cannot remove the last member of a household");
                $(checkbox).prop("checked", true);
                return;
            }
        }
        $(member_name).addClass("red-text");
        $(deleted).show();
        $(head_row).hide();
    }
}

$(document).ready(function() {
  if (!($("body.household").length > 0)) {
    return;
  }
  // Anything here will get executed when a page is rendered through the Households controller
});
