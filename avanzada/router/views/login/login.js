$('#login_form').submit(function (event) {
  event.preventDefault()
  const formData = new FormData(this) // Use 'this' to refer to the form element

  // Serializar el objeto FormData
  const serializedData = new URLSearchParams(formData)

  $.ajax({
    url: '/login',
    method: 'POST',
    data: formData,
    processData: false,
    contentType: false
  })
    .done(function (data) {
      console.log(data)
      window.location.href = '/'
    })
    .fail(function (jqXHR, textStatus, errorThrown) {
      console.error('Error:', errorThrown)
    })
})
