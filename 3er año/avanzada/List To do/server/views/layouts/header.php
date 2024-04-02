<!DOCTYPE html>
<html>

<head>
  <meta charset="UTF-8">
  <title>To-Do list!</title>
  <link rel="stylesheet" href="../../styles/styles.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
  <link rel="icon" href="/assets/icono.png" type="image/png">
</head>

<body>
  <header class="header">
    <div id="title_container">
      <h1>TO-DO <strong>LIST</strong></h1>
    </div>
    <?php
    if (isset($_SESSION['username'])) {
    ?>
      <form>
        <button type="submit" class="app-button">Salir</button>
      </form>
    <?php
    }
    ?>
  </header>