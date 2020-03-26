$(document).ready(function() {
  $(".launch-rec").click(function() {
    const extensionId = event.target.getAttribute('data-extension-id');
    try {
      chrome.runtime.sendMessage(extensionId, {
        message: "recommendation-selected",
        recommendationId: event.target.getAttribute('data-rec-id'),
        serviceId: event.target.getAttribute('data-svc-id'),
        cloned: event.target.getAttribute('data-cloned'),
        interactiveMode: true,
        apiUrl: window.location.origin + "/"
      }, function(response) {
        if(chrome.runtime.lastError || (response && response.error)) {
          handleExtensionError();
        }
      });
    } catch(err) {
      handleExtensionError();
    }
  });
});
function handleExtensionError() {
  alert("Please (re)install Privacy extension before proceeding");
}
