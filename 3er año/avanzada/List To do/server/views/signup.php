<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Registrarse</title>
  <link rel="stylesheet" href="/styles.css">
</head>

<body>
  <div class="container">
    <form id="signUpForm" class="centered-form">
      <?php require_once 'views/partial/form.php' ?>

      <label for="confirm_password">Confirme Password</label>
      <input type="password" name="confirm_password" required minlength="5" maxlength="25">

      <input type="submit" value="Sign Up" class="app-button">
    </form>

    <p id="error-message" class="error" style="display: none;"></p>
  </div>

  <script src="signup.js"></script>

  <?php require_once 'views\\layout\\footer.php'; ?>