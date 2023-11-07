<?php

namespace App\Controllers;

require_once(__DIR__ . '/../services/userService.php');
require_once(__DIR__ . '/../models/userViewModel.php');

use App\Models\UserViewModel;
use App\Services\UserService;

class UserController
{
  private static $instance;
  private $userService;

  public function __construct()
  {
    $this->userService = UserService::getInstance();
  }

  private function logError($message)
  {
    error_log($message);
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new UserController();
    }
    return self::$instance;
  }

  public function isLoggedIn()
  {
    if (isset($_SESSION['username'])) {
      error_log('Usuario autenticado en la página de inicio.');
      include_once(__DIR__ . "/../views/home/home.php");
    } else {
      include_once(__DIR__ . "/../views/login/login.php");
    }
  }

  public function logIn()
  {
    $userData = new UserViewModel($_POST);
    if ($userData->isValid()) {
      $result = $this->userService->logIn(get_object_vars($userData));
      if ($result) {
        $_SESSION['username'] = $userData->username;
        include_once(__DIR__ . "/../views/home/home.php");
      } else {
        $this->errorResponse($userData->getError());
        exit();
      }
    } else {
      $this->errorResponse($userData->getError());
      exit();
    }
  }
  public function getSignup()
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
          $this->errorResponse($userData->getError());
        }
      } else {
        $this->errorResponse($userData->getError());
      }
    } else {
    }
  }

  public function logOut()
  {
    session_unset();
    session_destroy();
    $this->loadView('login');
  }

  public function getUser()
  {
    return $_SESSION['username'] ?? null;
  }

  private function successResponse($data = null)
  {
    $response = [
      'status' => 'success',
      'data' => $data,
    ];

    http_response_code(200);
    header('Content-Type: application/json');
    echo json_encode($response);
    exit();
  }

  private function errorResponse($message)
  {
    $response = [
      'status' => 'error',
      'message' => $message,
    ];

    http_response_code(400);
    header('Content-Type: application/json');
    echo json_encode($response);
    exit();
  }


  private function jsonResponse($data)
  {
    return json_encode($data, JSON_UNESCAPED_UNICODE);
  }

  public function loadView($viewName)
  {
    include_once(__DIR__ . "/../views/$viewname/$viewname.php");
    unset($_SESSION['error_message']);
  }
}
