<?php

namespace App\Services;

use Exception;
use App\Services\BD\DBService;

require_once 'dbRepository/DBService.php';

class UserService
{
  private static $instance;
  private $dbInstance;

  public function __construct()
  {
    $this->dbInstance = DBService::getInstance();
  }

  private function logError($message)
  {
    error_log($message);
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new self();
    }
    return self::$instance;
  }

  public function logIn($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_LOGIN'], [$args['username']]);
      if ($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        $passwordMatch = password_verify($args['password'], $row['password']);
        if ($passwordMatch) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (Exception $e) {
      return $e->getMessage(); // Maneja la excepción de manera adecuada
    }
  }

  public function signUp($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_LOGIN'], [$args['username']]);
      if ($result->num_rows > 0) {
        return false;
      } else {
        $passwordHash = password_hash($args['password'], PASSWORD_BCRYPT);
        return $this->dbInstance->executeQuery($_ENV['QUERY_REGISTER'], [$args['username'], $passwordHash]);
      }
      return false;
    } catch (Exception $e) {
      return $e->getMessage(); // Maneja la excepción de manera adecuada
    }
  }

  public function changePassword($args)
  {
    try {
      if ($this->login($args)) {
        $passwordHash = password_hash($args['new-password'], PASSWORD_BCRYPT);
        $result = $this->dbInstance->executeQuery($_ENV['QUERY_MODIFY_PASSWORD'], [$args['username'], $passwordHash]);
        if ($result->num_rows > 0) {
          return true;
        } else {
          return null;
        }
      }
    } catch (Exception $e) {
      return $e->getMessage(); // Maneja la excepción de manera adecuada
    }
  }
}
