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

export { isValidUsername, isValidPassword, areWordsEqual }
