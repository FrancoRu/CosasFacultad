<?php

namespace App\Controllers;

require_once(__DIR__ . '/../services/userService.php');

use App\Models\UserViewModel;
use App\Services\UserService;

class LoginController
{
  private $userService;

  public function __construct()
  {
    $this->userService = new UserService(); // Asegúrate de instanciar el servicio adecuado
  }

  public function login()
  {
    $userData = new UserViewModel($_POST);
    if ($userData->isValid()) {
      $result = $this->userService->logIn(get_object_vars($userData));
      if ($result) {
        $_SESSION['username'] = $userData->username;
        include_once(__DIR__ . "/../views/home/home.php");
      } else {
        include_once(__DIR__ . "/../views/login/login.php");
      }
    } else {
      include_once(__DIR__ . "/../views/login/login.php");
    }
  }
}
