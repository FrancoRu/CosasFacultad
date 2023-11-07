<?php

namespace App\Models;

class UserViewModel
{
  public $username;
  public $password;
  private $error;

  public function __construct($args = [])
  {
    $this->username = $args['username'] ?? null;
    $this->password = $args['password'] ?? null;
  }

  public function isValid()
  {
    return $this->isValidUsername() && $this->isValidPassword();
  }

  private function isValidUsername()
  {
    if (empty($this->username) || strlen($this->username) > 25 || strlen($this->username) < 5 || !is_string($this->username)) {
      $this->error = $this->createError('Nombre de usuario inválido.');
      return false;
    }

    return true;
  }

  private function isValidPassword()
  {
    $errors = array();

    if (empty($this->password) || !is_string($this->password)) {
      $errors[] = $this->createError('Contraseña inválida.');
    }

    if (strlen($this->password) < 5 || strlen($this->password) > 25) {
      $errors[] = $this->createError('La contraseña debe tener entre 5 y 25 caracteres.');
    }

    // if (!preg_match('/^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).+$/', $this->password)) {
    //   $errors[] = $this->createError('La contraseña debe contener al menos una letra mayúscula, un símbolo y un número.');
    // }

    if (!empty($errors)) {
      $this->error = implode(' ', $errors); // Combina los mensajes de error en un solo mensaje
      return false;
    }

    return true;
  }

  public function getNombre()
  {
    return $this->username;
  }

  public function getError()
  {
    return $this->error;
  }

  private function createError($message)
  {
    return [
      'error' => 400,
      'message' => $message,
    ];
  }
}
