<?php $userController = UserController::getInstance(); ?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Your Page Title</title>
</head>

<body>
  <?php if ($userController->isLoggedIn()) { ?>
    <header class="header">
      <div class="header-image">
        <img src="/assets/header.jpg" alt="Header Image for FCyT">
      </div>
      <form method="POST" action="/logout">
        <button type="submit" class="app-button">Logout</button>
      </form>
    </header>
  <?php } ?>