$(document).ready(function () {
  const loginForm = $('#loginForm')
  const errorMessage = $('#error-message')
  const usernameInput = $('[name="username"]')
  const passwordInput = $('[name="password"]')

  loginForm.on('submit', function (event) {
    event.preventDefault()

    const username = usernameInput.val()
    const password = passwordInput.val()

    if (validateUsername(username) && validatePassword(password)) {
      $.ajax({
        type: 'POST',
        url: '/login',
        data: JSON.stringify({ username, password }),
        contentType: 'application/json',
        success: function (data) {
          // Handle the backend response
          if (data.success) {
            // Redirect to the home page or perform other actions
            window.location.href = '/home'
          } else {
            // Show an error message
            errorMessage.css('display', 'block')
            errorMessage.text(data.error)
          }
        },
        error: function (jqXHR, textStatus, errorThrown) {
          console.error('Error:', errorThrown)
        }
      })
    }
  })

  function validateUsername(username) {
    if (username.length < 5 || username.length > 25) {
      errorMessage.css('display', 'block')
      errorMessage.text('Username must be between 5 and 25 characters.')
      return false
    }
    return true
  }

  function validatePassword(password) {
    const passwordRegex =
      /^(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,25}$/
    if (!passwordRegex.test(password)) {
      errorMessage.css('display', 'block')
      errorMessage.text(
        'Password must contain at least one uppercase letter, one symbol, one number, and be between 5 and 25 characters.'
      )
      return false
    }
    return true
  }
})
