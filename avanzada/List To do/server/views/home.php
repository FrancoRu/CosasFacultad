<?php
$pageTitle = "Página Principal";
$pageDescription = "Bienvenido a la página principal de mi sitio web.";
require_once 'layout/header.php';
?>

<div class="main-content">
  <div class="home-container">
    <h2>Bienvenido a la pagina principal</h2>
    <p class="success">Ingreso correctamente como <?php echo $_SESSION['username']; ?>!</p>
  </div>
</div>

<?php require_once 'layout/footer.php'; ?>