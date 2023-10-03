<?php
require_once './controllers/UserControllers.php';
$user = User::getInstance();

if (
  $_SERVER['REQUEST_URI'] === '/login' ||
  $_SERVER['REQUEST_URI'] === '/'
) {
  $user->login();
} elseif ($_SERVER['REQUEST_URI'] === '/home') {
  $user->login();
} elseif ($_SERVER['REQUEST_URI'] === '/signup') {
  $user->signup();
} elseif ($_SERVER['REQUEST_URI'] === '/logout') {
  $user->logout();
} else {
  echo '404 - Page not found';
  echo $_SERVER['REQUEST_URI'];
}