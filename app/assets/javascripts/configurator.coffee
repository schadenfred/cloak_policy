$(document).on 'turbolinks:load', ->
  $('#generateRecommendation').hide()
  useCases = $('#configuration_use_case_id').html()

  $('#configuration_profile_id').change ->
    profile = $( "#configuration_profile_id option:selected" ).text()
    profileData = $('#profiles').data('profiles')["#{profile}"]
    $('#profileDescription').html(profileData)
    options = $(useCases).filter("optgroup[label='#{profile}']").html()

    if options
      $('#configuration_use_case_id').html options
      $('#generateRecommendation').show()
    else
      $('#configuration_use_case_id').empty()
      $('#generateRecommendation').hide()

    use_case = $( "#configuration_use_case_id option:selected" ).text()
    useCaseData = $('#use_cases').data('useCases')["#{use_case}"]
    $('#useCaseDescription').html(useCaseData)

  $('#configuration_use_case_id').change ->
    use_case = $( "#configuration_use_case_id option:selected" ).text()
    useCaseData = $('#use_cases').data('useCases')["#{use_case}"]
    $('#useCaseDescription').html(useCaseData)

  if $('#welcome-header').length
    extensionId = $('#welcome-header').attr('data-extension-id')
    email = $('#welcome-header').attr('data-user-email')
    authentication_token = $('#welcome-header').attr('data-user-authentication-token')
    refresh_token = $('#welcome-header').attr('data-user-refresh-token')
    console.log('refresh_token: ', refresh_token)
    chrome.runtime.sendMessage extensionId, {
        message: 'user-created',
        email: email,
        authenticationToken: authentication_token,
        refreshToken: refresh_token
      }, (response) ->
        console.log('response: ', response)
        if chrome.runtime.lastError or response and response.error
          console.log 'Error sending message: user-created'

  $('#openExtensionDashboard').click ->
    extensionId = $(this).attr('data-extension-id')
    chrome.runtime.sendMessage extensionId, { message: 'open-dashboard' }, (response) ->
      if chrome.runtime.lastError or response and response.error
        console.log 'Error sending message: open-dashboard'
