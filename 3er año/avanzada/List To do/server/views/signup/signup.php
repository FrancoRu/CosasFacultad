<?php require_once '../layouts/header.php' ?>

<form id="signup_form">
  <div class="form-group">
    <label for="username">Usuario</label>
    <input type="text" class="form-control" name="username" required minlength="5" maxlength="25" id="username">
  </div>

  <div class="form-group">
    <label for="password">Contraseña</label>
    <input type="password" class="form-control" name="password" required minlength="5" maxlength="25" id="password">
  </div>

  <div class="form-group">
    <label for="confirm_password">Confirmar Contraseña</label>
    <input type="password" class="form-control" name="confirm_password" required minlength="5" maxlength="25" id="confirmpassword">
  </div>

  <button type="submit" class="btn btn-primary" id="signup_btn">Registrarse</button>
</form>


<script src="signup.js"></script>

<?php require_once '../layouts/footer.php' ?>