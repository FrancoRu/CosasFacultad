import { isValidUsername, isValidPassword } from './utils'

$(function () {
  const loginForm = $('#loginForm')
  const errorMessage = $('#error-message')
  const usernameInput = $('[name="username"]')
  const passwordInput = $('[name="password"]')

  loginForm.on('submit', async function (event) {
    event.preventDefault()

    const username = usernameInput.val()
    const password = passwordInput.val()

    if (isValidUsername(username) && isValidPassword(password)) {
      try {
        const response = await $.ajax({
          type: 'POST',
          url: '/login',
          data: JSON.stringify({ username, password }),
          contentType: 'application/json'
        })

        if (response.success) {
          window.location.href = '/home'
        } else {
          errorMessage.css('display', 'block')
          errorMessage.text(response.error)
        }
      } catch (error) {
        console.error('Error:', error)
      }
    }
  })
})
