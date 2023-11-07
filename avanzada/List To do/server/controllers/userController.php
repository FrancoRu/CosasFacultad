<?php
require_once 'server/../services/userService.php';
require_once 'server/../models/userViewModel.php';

class UserController
{
  private static $instance;
  private $userService;

  private function __construct()
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

  public function isLoggedIn($args)
  {
    if (!isset($_SESSION['username'])) {
      $this->redirectToView('home');
      exit();
    }
    $this->redirectToView('login');
    exit();
  }

  public function logIn($args)
  {
    $userData = new UserViewModel($args);
    if ($userData->isValid()) {
      $result = $this->userService->logIn(get_object_vars($userData));
      if ($result) {
        $_SESSION['username'] = $userData->username;
        header("Location: /views/home/home.php");
        exit();
      } else {
        $this->errorResponse($userData->getError());
        exit();
      }
    } else {
      $this->errorResponse($userData->getError());
      exit();
    }
  }

  public function signUp($args)
  {
    $this->logError("entramos al metodo");
    if ($args['confirm_password'] === $args['password']) {
      $this->logError("entramos a la igualdad");
      $userData = new UserViewModel($args);
      if ($userData->isValid()) {
        $this->logError("entramos validado");
        $result = $this->userService->signUp(get_object_vars($userData));
        if ($result) {
          $this->logError("entramos al resultado");
          $_SESSION['username'] = $userData->username;
          $this->isLoggedIn($args);
        } else {
          $this->errorResponse($userData->getError());
          $this->logError("fallo: " . $userData->getError());
        }
      } else {
        $this->errorResponse($userData->getError());
        $this->logError("fallo la data del user " . $userData->getError());
      }
    } else {
      $this->logError("no eran iguales las pass");
    }
  }

  public function logOut()
  {
    session_unset();
    session_destroy();
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
  private function redirectToView($viewName)
  {
    $viewPath = "server/../views/$viewName/$viewName.php";

    if (file_exists($viewPath)) {
      // La vista existe, así que redirigimos al usuario a la URL de la vista
      header("Location: /$viewPath");
      exit; // Asegúrate de detener la ejecución del script después de la redirección
    } else {
      // La vista no se encuentra, puedes redirigir al usuario a una página de error o a otra URL
      header("Location: /");
      exit;
    }
  }
}
