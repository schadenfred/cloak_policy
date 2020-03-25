$(document).on('turbolinks:load', function() {
  $('#generateRecommendation').hide();

  var useCases = $('#configuration_use_case_id').html();

  $('#configuration_profile_id').change(function() {
    $('#profileDescription').html($(this).val());
  });

  $('#configuration_use_case_id').change(function() {
    $('#useCaseDescription').html($(this).val());
  });

  if ($('#welcome-header').length) {
    var extensionId = $('#welcome-header').attr('data-extension-id');
    var email = $('#welcome-header').attr('data-user-email');
    var authentication_token = $('#welcome-header').attr('data-user-authentication-token');
    var refreshToken = $('#welcome-header').attr('data-user-refresh-token');

    chrome.runtime.sendMessage(extensionId, {
      message: 'user-created',
      email: email,
      authenticationToken: authentication_token,
      refreshToken: refresh_token
    }, function(response) {
      console.log('response: ', response);
      if (chrome.runtime.lastError || response && response.error) {
        return console.log('Error sending message: user-created');
      }
    });
  }
});
