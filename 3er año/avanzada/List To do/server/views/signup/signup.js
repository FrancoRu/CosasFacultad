function isValidUsername(username) {
  return /^[a-zA-Z0-9]{5,25}$/.test(username)
}

function isValidPassword(password) {
  const passwordPattern =
    /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,25}$/
  return passwordPattern.test(password)
}

function areWordsEqual(word1, word2) {
  return word1 === word2
}

$(document).ready(function () {
  $('#signup_form').submit(function (event) {
    event.preventDefault()
    const formData = new FormData($('#signup_form')[0])

    const username = formData.get('username')
    const password = formData.get('password')
    const confirmPassword = formData.get('confirm_password')

    $('.form-control').removeClass('is-invalid')

    let hasError = false

    if (!isValidUsername(username)) {
      $('#username').addClass('is-invalid')
      $.notify('Invalid username', 'error')
      hasError = true
    }

    if (!isValidPassword(password)) {
      $('#password').addClass('is-invalid')
      $.notify('Invalid password', 'error')
      hasError = true
    }

    if (!areWordsEqual(password, 'confirm_password')) {
      $('#confirmpassword').addClass('is-invalid')
      $.notify('Passwords do not match', 'error')
      hasError = true
    }

    if (!hasError) {
      $.ajax({
        url: '../../../index.php/signup',
        method: 'POST',
        data: formData,
        processData: false,
        contentType: false
      }).fail(function (jqXHR, textStatus, errorThrown) {
        console.error('Error:', errorThrown)
      })
    }
  })
})
