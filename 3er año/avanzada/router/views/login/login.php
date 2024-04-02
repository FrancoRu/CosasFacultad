<?php
require_once(__DIR__ . '/../layouts/header.php');
?>

<form id="login_form" method="post">
  <label for="username">Usuario</label>
  <input type="text" name="username" required minlength="5" maxlength="25">

  <label for="password">Contraseña</label>
  <input type="password" name="password" required minlength="5" maxlength="25">
  <button class="btn btn-primary" type="submit" id="login_btn">Iniciar</button>
</form>
<a href="/signup">Sign Up</a>
<script src="views/login/login.js"></script>
<?php
require_once(__DIR__ . '/../layouts/footer.php');
?>