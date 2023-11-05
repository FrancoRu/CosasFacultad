document.addEventListener('DOMContentLoaded', () => {
  const logoutButton = document.getElementById('logoutButton')

  if (logoutButton) {
    logoutButton.addEventListener('click', async (event) => {
      event.preventDefault()

      try {
        const response = await fetch('/logout', {
          method: 'POST'
        })

        if (response.ok) {
          const data = await response.json()

          if (data.success) {
            window.location.href = '/login'
          }
        } else {
          console.error('Error:', response.statusText)
        }
      } catch (error) {
        console.error('Error:', error)
      }
    })
  }
})
