$(document).ready(function() {
  $("[data-behavior=submit-on-click]").click( function(event) {
    var chosen = JSON.parse(event.target.getAttribute('data-chosen'));
    $.ajax({
      url: "/chosens",
      type: "post",
      data: {chosen},
      dataType: 'json',
      success: function(data) {},
      error: function(data) {}
    })
  }
)});
