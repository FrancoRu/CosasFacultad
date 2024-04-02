import { isValidUsername, isValidPassword } from './utils'

$(function () {
  const signUpForm = $('#signUpForm')
  const errorMessage = $('#error-message')

  signUpForm.on('submit', async function (event) {
    event.preventDefault()

    const username = $('[name="username"]').val()
    const password = $('[name="password"]').val()
    const confirm_password = $('[name="confirm_password"]').val()

    if (!isValidUsername(username)) {
      displayErrorMessage('Username must be between 5 and 25 characters.')
      return
    }

    if (!isValidPassword(password)) {
      displayErrorMessage(
        'Password must contain at least one uppercase letter, one symbol, one number, and be between 5 and 25 characters.'
      )
      return
    }

    if (password !== confirm_password) {
      displayErrorMessage('Passwords do not match.')
      return
    }

    try {
      const response = await $.ajax({
        type: 'POST',
        url: '/signup',
        data: JSON.stringify({ username, password, confirm_password }),
        contentType: 'application/json'
      })

      if (response.success) {
        window.location.href = '/home'
      } else {
        displayErrorMessage(response.error)
      }
    } catch (error) {
      console.error('Error:', error)
    }
  })

  function displayErrorMessage(message) {
    errorMessage.css('display', 'block')
    errorMessage.text(message)
  }
})
