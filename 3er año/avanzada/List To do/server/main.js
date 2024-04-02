$(document).ready(function () {
  $(document).ready(function () {
    $.ajax({
      url: 'index.php/', // Ajusta la URL a la ruta correcta
      method: 'GET',
      success: function (response) {
        if (response) {
          const data = JSON.parse(response)
          $('#container').html(data)
          init()
        } else {
          console.log('La respuesta está vacía o no es un JSON válido.')
        }
      },
      error: function (xhr, status, error) {
        console.log('Error en la solicitud AJAX:')
        console.log('Código de estado:', xhr.status)
        console.log('Mensaje de error:', error)
      }
    })
  })
})

function init() {
  $('#logoutBtn').on('click', function (event) {
    event.preventDefault()
    $.ajax({
      url: 'index.php/tasks/',
      method: 'GET',
      success: function (response) {
        if (response) {
          $('#container').removeClass('ocultar')
          const data = JSON.parse(response)
          $('#container').html(data)
          init()
        } else {
          console.log('La respuesta está vacía o no es un JSON válido.')
        }
      },
      error: function (xhr, status, error) {
        console.log('Error en la solicitud AJAX:')
        console.log('Código de estado:', xhr.status)
        console.log('Mensaje de error:', error)
      }
    })
  })

  $('#loginForm').on('submit', function (event) {
    event.preventDefault()
    const formData = new FormData($('#loginForm')[0])

    // Utiliza jQuery para realizar la solicitud AJAX en lugar de fetch
    $.ajax({
      url: 'index.php/login',
      method: 'POST',
      data: formData,
      processData: false, // Evita que jQuery procese los datos
      contentType: false // Establece el tipo de contenido a "false" para FormData
    })
      .done(function (response) {
        const data = JSON.parse(response)
        console.log(data)
        $('#container').empty()
        $('#container').html(data)
      })
      .fail(function (jqXHR, textStatus, errorThrown) {
        console.error('Error:', errorThrown)
      })
  })
}

$('#BtnPrueba').on('click', function (event) {
  event.preventDefault()
  var projectId = 'Pro1' // Reemplaza 123 con el valor desead
  $.ajax({
    url: 'index.php/tasks',
    method: 'POST',
    data: { project_id: projectId }
  })
    .done(function (response) {
      $('#contain-table').empty()
      $('#contain-table').append(response)
      $('#table').DataTable()
    })
    .fail(function (xhr, status, error) {
      console.log('Error en la solicitud AJAX:')
      console.log('Código de estado:', xhr.status)
      console.log('Mensaje de error:', error)
    })
})
