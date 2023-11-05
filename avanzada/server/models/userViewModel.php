<?php
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

  public function isValidUsername()
  {
    if (empty($this->username) || strlen($this->username) > 25 || strlen($this->username) < 5 || !is_string($this->username)) {
      $this->error = $this->createError('Nombre de usuario inválido.');
      return false;
    }

    return true;
  }

  public function isValidPassword()
  {
    if (empty($this->password) || !is_string($this->password)) {
      $this->error = $this->createError('Contraseña inválida.');
      return false;
    }

    if (strlen($this->password) < 5 || strlen($this->password) > 25) {
      $this->error = $this->createError('La contraseña debe tener entre 5 y 25 caracteres.');
      return false;
    }

    if (!preg_match('/^(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=]).+$/', $this->password)) {
      $this->error = $this->createError('La contraseña debe contener al menos una letra mayúscula, un símbolo y un número.');
      return false;
    }

    return true;
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
