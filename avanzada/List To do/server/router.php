<?php
define('DIR', __DIR__);

$requestUri = $_SERVER['REQUEST_URI'];
$requestMethod = $_SERVER['REQUEST_METHOD'];
$routes = include 'routes.php';

if (array_key_exists($requestUri, $routes)) {
  if (array_key_exists($requestMethod, $routes[$requestUri])) {
    list($controllerName, $methodName) = explode('@', $routes[$requestUri][$requestMethod]);
    $controllerFile = DIR . '\\controllers\\' . $controllerName . '.php';
    if (file_exists($controllerFile)) {
      require $controllerFile;
      $controller = $controllerName::getInstance();
      $controller->$methodName();
    } else {
      http_response_code(404);
      echo 'Controllador no encontrado';
    }
  } else {
    http_response_code(405);
    echo 'Método no encontrado para esta ruta';
  }
} else {
  http_response_code(404);
  echo 'Ruta no encontrada';
}
