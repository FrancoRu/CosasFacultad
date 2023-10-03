<?php

require_once(__DIR__ . '/../services/userManagement.php');

class User
{
  private static $instance;
  private $user;
  private $username;

  private function __construct()
  {
    $this->user = UserManagement::getInstance();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new User();
    }
    return self::$instance;
  }

    public function isLogin()
    {
      if (isset($_SESSION['username'])) {
        $this->loadView('home');
        exit();
      } else {
        $this->loadView('login');
        exit();
      }
    }

    public function login()
    {
      if (isset($_SESSION['username'])) {
        $this->isLogin();
      } elseif ($_SERVER["REQUEST_METHOD"] == "POST") {
        $username = $_POST['username'];
        $password = $_POST['password'];
        $result = $this->user->validateCredential($username, $password);
        if ($result) {
          $_SESSION['username'] = $username;
          $this->isLogin();
        } else {
          $this->loadView('login', 'Username or password incorrect!!');
          exit();
        }
      } else {
        $this->loadView('login');
        exit();
      }
    }

  public function signup()
  {
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
      $usern = $_POST['username'];
      $pass = $_POST['password'];
      $confirm_pass = $_POST['confirm_password'];
      if ($pass === $confirm_pass) {
        $result = $this->user->addUser($usern, $pass);
        if ($result) {
          $_SESSION['username'] = $usern;
          $this->isLogin();
        } else {
          $this->loadView('signup', 'User already exists');
        }
      } else {
        $this->loadView('signup', 'Passwords must be the same');
      }
    } else {
      $this->loadView('signup');
    }
  }

  public function logout()
  {
    session_unset();
    session_destroy();
    header("Location: /login");
    exit();
  }

  public function getUser()
  {
    return $this->username;
  }

  private function loadView($viewName, $error_message = null)
  {
    if ($error_message) {
      $_SESSION['error_message'] = $error_message;
    }
    include_once "views/$viewName.php";
    unset($_SESSION['error_message']);
  }
}