<?php $userController = UserController::getInstance(); ?>

<?php require_once 'views/layout/header.php'; ?>

<div class="main-content">
  <div class="home-container">
    <h2>Bienvenido a la pagina principal</h2>
    <p class="success">Ingreso correctamente como <?php echo $userController->getUser(); ?>!</p>
  </div>
</div>

<?php require_once 'views/layout/footer.php'; ?>