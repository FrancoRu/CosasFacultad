<?php
require_once './vendor/autoload.php';
require_once 'controllers/HomeController.php';
require_once 'controllers/AboutController.php';
require_once 'controllers/UserController.php';
require_once 'controllers/LoginController.php';
require_once 'controllers/SignupController.php';

$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->safeLoad();

use Phroute\Phroute\RouteCollector;

$router = new RouteCollector();

$router->get('/', ['App\Controllers\HomeController', 'index']);
$router->post('/login', ['App\Controllers\LoginController', 'login']);
$router->get('/signup', ['App\Controllers\SignupController', 'index']);
$router->post('/signup', ['App\Controllers\SignupController', 'signup']);



$dispatcher = new Phroute\Phroute\Dispatcher($router->getData());

try {
  $response = $dispatcher->dispatch($_SERVER['REQUEST_METHOD'], parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH));
  echo $response;
} catch (Phroute\Phroute\Exception\HttpRouteNotFoundException $e) {
  echo "Ruta no encontrada";
} catch (Phroute\Phroute\Exception\HttpMethodNotAllowedException $e) {
  echo "Método no permitido";
}
