<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>Inicio de Sesion</title>
  <link rel="stylesheet" href="/styles.css">
</head>

<body>
  <div class="container">
    <form id="loginForm" action="/" method="post">
      <?php require_once 'views/partial/form.php' ?>
      <input type="submit" value="Ingresar" class="app-button">
    </form>
    <p id="error-message" class="error" style="display: none;"></p>
  </div>

  <script src="login.js"></script>

  <?php require_once 'views\\layouts\\footer.php'; ?>