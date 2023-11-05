<?php
require_once 'php/../services/userService.php';
require_once 'php/../models/userViewModel.php';

class UserController
{
  private static $instance;
  private $userService;

  private function __construct()
  {
    $this->userService = UserService::getInstance();
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
      $this->redirectTo('home');
    } else {
      $this->redirectTo('login');
    }
  }

  public function logIn()
  {
    if (!isset($_SESSION['username'])) {
      $this->redirectTo('login');
      return;
    }

    $userViewModel = new UserViewModel($_POST);

    if ($userViewModel->isValid()) {
      $result = $this->userService->logIn($userViewModel);
      if ($result) {
        $_SESSION['username'] = $userViewModel->username;
        $this->isLoggedIn();
      } else {
        $this->redirectTo('login', 'Username or password incorrect!');
      }
    } else {
      $this->redirectTo('login');
    }
  }

  public function signUp()
  {
    $userViewModel = new UserViewModel($_POST);

    if ($userViewModel->isValid()) {
      $result = $this->userService->signUp($userViewModel);
      if ($result) {
        $_SESSION['username'] = $userViewModel->username;
        $this->isLoggedIn();
      } else {
        $this->redirectTo('signup', 'User already exists');
      }
    } else {
      $this->redirectTo('signup', 'Passwords must be the same');
    }
  }

  public function changePassword()
  {
    if (!isset($_SESSION['username'])) {
      $this->redirectTo('login');
      return;
    }

    $userData = new UserViewModel($_POST);

    if ($userData->isValidUsername() && $userData->isValidPassword()) {
      $result = $this->userService->changePassword(get_object_vars($userData));

      if ($result === true) {
        $this->redirectTo('home');
      } else {
        $this->redirectTo('home', 'Password change failed');
      }
    } else {
      $this->redirectTo('home', 'Password validation error');
    }
  }

  public function logOut()
  {
    session_unset();
    session_destroy();
    $this->redirectTo('login');
  }

  public function getUser()
  {
    return $_SESSION['username'] ?? null;
  }

  private function redirectTo($viewName, $error_message = null)
  {
    if ($error_message) {
      $_SESSION['error_message'] = $error_message;
    }

    include_once "views/$viewName.php";
    unset($_SESSION['error_message']);
    exit();
  }
}
