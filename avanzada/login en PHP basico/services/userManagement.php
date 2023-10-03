<?php

require 'dbManager.php';

class UserManagement
{
  private static $instance;
  private $db;
  private $conn;

  private function __construct()
  {
    $this->db = DBManager::getInstance();
    $this->conn = $this->db->connection();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new self();
    }
    return self::$instance;
  }

  public function validateCredential($username, $password)
  {
    $user = $this->findUsername($username);
    if ($user === false) {
      return false;
    }
    return password_verify($password, $user['password']);
  }

  public function findUsername($username)
  {
    $sql = "SELECT * FROM users WHERE username = :username";
    $stmt = $this->conn->prepare($sql);
    $stmt->bindParam(':username', $username);
    $stmt->execute();
    return $stmt->fetch(PDO::FETCH_ASSOC);
  }

  public function addUser($username, $password)
  {
    if ($this->findUsername($username)) {
      return false;
    }
    $sql = "INSERT INTO users (username, password) VALUES (:username, :password)";
    $stmt = $this->conn->prepare($sql);
    $stmt->bindParam(':username', $username);
    $password_hash = password_hash($password, PASSWORD_BCRYPT);
    $stmt->bindParam(':password', $password_hash);
    return $stmt->execute();
  }
}
