$ ->
  $("#upload-image").fileupload
  add: (e, data) ->
    data.context = $("#submit-data")
    data.submit()