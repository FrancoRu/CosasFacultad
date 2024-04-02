<?php

namespace App\Controllers;

class HomeController
{
  public function index()
  {
    if (isset($_SESSION['usernama'])) {
      include_once(__DIR__ . '/../views/home.php');
    } else {
      include_once(__DIR__ . '/../views/login/login.php');
    }
  }
}
