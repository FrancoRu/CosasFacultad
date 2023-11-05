<?php
define('DIR', __DIR__);

$requestUri = $_SERVER['REQUEST_URI'];
$requestMethod = $_SERVER['REQUEST_METHOD'];

// Include the routes definitions
$routes = include 'routes.php';

// Parse the request and execute the corresponding controller method
if (array_key_exists($requestUri, $routes)) {
  if (array_key_exists($requestMethod, $routes[$requestUri])) {
    list($controllerName, $methodName) = explode('@', $routes[$requestUri][$requestMethod]);
    $controllerFile = DIR . '/controllers/' . $controllerName . '.php';

    if (file_exists($controllerFile)) {
      require $controllerFile;
      $controller = new $controllerName();
      $controller->$methodName();
    } else {
      http_response_code(404);
      echo 'Controller not found';
    }
  } else {
    http_response_code(405);
    echo 'Method not allowed for this route';
  }
} else {
  http_response_code(404);
  echo 'Route not found';
}

//que es esto tarantula