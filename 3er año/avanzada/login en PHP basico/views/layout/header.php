
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="../styles/main.css">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous" defer></script>

  <title>Login</title>

</head>

<body>

  <header class="bg-primary text-white">
    <nav>
      <?php if (isset($_SESSION['username'])) : ?>
        <div class="button-container ml-2 mt-2">
          <h1>Home</h1>
        </div>
      <?php elseif ($_SERVER['REQUEST_URI'] === '/signup') : ?>
        <div class="button-container ml-2 mt-2">
          <h1>Sign up</h1>
        </div>
        <?php else : { ?>
          <div class="button-container ml-2 mt-2">
            <h1>Login</h1>
          </div>
      <?php }
      endif; ?>
    </nav>
  </header>
