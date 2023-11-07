<?php require_once '../layouts/header.php' ?>
<form id="login_form">
  <label for="username">Usuario</label>
  <input type="text" name="username" required minlength="5" maxlength="25">

  <label for="password">Contraseña</label>
  <input type="password" name="password" required minlength="5" maxlength="25">
  <button class="btn btn-primary" type="submit" id="login_btn">Iniciar</button>
</form>
<script src="login.js"></script>
<?php require_once '../layouts/footer.php' ?>