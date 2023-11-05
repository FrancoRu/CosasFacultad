<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Inicio de Sesion</title>
  <link rel="stylesheet" href="/styles.css">
</head>

<body>
  <div class="container">
    <form id="loginForm" class="centered-form">
      <label for="username">Usuario</label>
      <input type="text" name="username" required minlength="5" maxlength="25">

      <label for="password">Contraseña</label>
      <input type="password" name="password" required minlength="5" maxlength="25">

      <input type="submit" value="Ingresar" class="app-button">
    </form>

    <p id="error-message" class="error" style="display: none;"></p>
  </div>

  <script src="login.js"></script>

  <?php require_once 'views/layout/footer.php'; ?>