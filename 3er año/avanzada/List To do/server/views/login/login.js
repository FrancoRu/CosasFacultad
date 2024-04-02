$(document).ready(function () {
  $('#login_form').submit(function (event) {
    event.preventDefault()
    const formData = new FormData($('#login_form')[0])
    $.ajax({
      url: '../../../index.php/login',
      method: 'POST',
      data: formData,
      processData: false,
      contentType: false
    }).fail(function (jqXHR, textStatus, errorThrown) {
      console.error('Error:', errorThrown)
    })
  })
})
