<?php
require_once 'server/../services/userService.php';
require_once 'server/../models/userViewModel.php';

class UserController
{
  private static $instance;
  private $userService;
  private $tag;

  private function __construct()
  {
    $this->userService = UserService::getInstance();
    $this->tag = TagService::getInstance();
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
    if (!isset($_SESSION['username'])) {
      return $this->tag::getFormLogin();
    }
    return $this->tag::getHome();
  }

  public function logIn()
  {
    $userData = new UserViewModel($_POST);
    if ($userData->isValid()) {
      $result = $this->userService->logIn(get_object_vars($userData));
      if ($result) {
        $_SESSION['username'] = $userData->username;
        $this->isLoggedIn();
      } else {
        $this->errorResponse($userData->getError());
      }
    } else {
      $this->errorResponse($userData->getError());
    }
  }

  public function signUp()
  {
    if ($_POST['confirm_password'] === $_POST['password']) {
      $userData = new UserViewModel($_POST);
      if ($userData->isValid()) {
        $result = $this->userService->signUp(get_object_vars($userData));
        if ($result) {
          $_SESSION['username'] = $userData->username;
          $this->isLoggedIn();
        } else {
          $this->errorResponse($userData->getError());
        }
      } else {
        $this->errorResponse($userData->getError());
      }
    }
  }

  public function changePassword()
  {
    if (!isset($_SESSION['username'])) {
      $this->errorResponse('user no valid');
      return;
    }

    $userData = new UserViewModel($_POST);

    if ($userData->isValid()) {
      $result = $this->userService->changePassword(get_object_vars($userData));
      if ($result === true) {
        $this->successResponse($userData->getNombre());
      } else {
        $this->errorResponse($userData->getError());
      }
    } else {
      $this->errorResponse($userData->getError());
    }
  }

  public function logOut()
  {
    session_unset();
    session_destroy();
    $this->tag::getFormLogin();
  }

  public function getUser()
  {
    return $_SESSION['username'] ?? null;
  }

  private function successResponse($data)
  {
    http_response_code(200);
    $this->jsonResponse($data);
  }

  private function errorResponse($data)
  {
    http_response_code(400);
    $this->jsonResponse($data);
  }

  private function jsonResponse($data)
  {
    return json_encode($data, JSON_UNESCAPED_UNICODE);
  }
}
