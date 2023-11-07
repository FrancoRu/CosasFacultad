<?php

namespace App\Controllers;

require_once(__DIR__ . '/../services/userService.php');

use App\Models\UserViewModel;
use App\Services\UserService;

class SignupController
{
  private $userService;

  public function __construct()
  {
    $this->userService = new UserService(); // Asegúrate de instanciar el servicio adecuado
  }

  public function index()
  {
    include_once(__DIR__ . "/../views/signup/signup.php");
  }



  public function signup()
  {
    if ($_POST['confirm_password'] === $_POST['password']) {
      $userData = new UserViewModel($_POST);
      if ($userData->isValid()) {
        $result = $this->userService->signUp(get_object_vars($userData));
        if (!$result) {
          $_SESSION['username'] = $userData->username;
          include_once(__DIR__ . "/../views/home/home.php");
        } else {
          include_once(__DIR__ . "/../views/signup/signup.php");
        }
      } else {
        include_once(__DIR__ . "/../views/dignup/signup.php");
      }
    } else {
    }
  }
}
