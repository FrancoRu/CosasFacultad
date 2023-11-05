<?php $userController = UserController::getInstance(); ?>
<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title><?php echo $pageTitle; ?></title>
  <meta name="description" content="<?php echo $pageDescription; ?>">
  <link rel="stylesheet" href="/styles.css">
</head>

<body>
  <?php if ($userController->isLoggedIn()) { ?>
    <header class="header">
      <div class="header-image">
        <img src="/assets/header.jpg" alt="Imágen de cabecera para la FCyT">
      </div>
      <form method="POST" action="/logout">
        <button type="submit" class="app-button">Salir</button>
      </form>
    </header>
  <?php } ?>