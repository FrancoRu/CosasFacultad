
<?php

class DBManager
{
  private static $instance;
  private $server;
  private $username;
  private $password;
  private $database;

  private function __construct()
  {
    $this->server = 'localhost:3306';
    $this->username = 'root';
    $this->password = '';
    $this->database = 'php_logueo';
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new self();
    }
    return self::$instance;
  }

  public function connection()
  {
    try {
      $conn = new PDO("mysql:host=$this->server;dbname=$this->database", $this->username, $this->password);
      $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $conn;
    } catch (PDOException $e) {
      die('Connection failed: ' . $e->getMessage());
    }
  }
}
