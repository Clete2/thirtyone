App.Local_Resources = {};

$(document).ready(function() {
  if (!($("body.local_resources").length > 0)) {
    return;
  }

  $("input#local_resource_phone").inputmask("(999) 999-9999");
  $("input#local_resource_phone_ext").inputmask("9999999999");
  $("input#local_resource_address_attributes_zip").inputmask("99999");

  $("div.expand").click(function () {
    $(this).closest("div.row").find("div.content").slideToggle('slow');
    var toggle = $(this).find("span.toggle");

    toggle.text(toggle.text() === '▼' ? '►' : '▼')
  });
});

App.Local_Resources.updateLocalResourceSearch = function(input) {

    var form = $(input).closest('form');
    var request = $.ajax({
        url: $(form).attr('action'),
        type: "GET",
        data: $(form).serialize(),
        dataType: "html"
    });

    request.done(function (html) {
        $("#results").html(html)
    });

    request.fail(function (jqXHR, textStatus) {
        alert("Search update failed: " + textStatus);
    });
}
