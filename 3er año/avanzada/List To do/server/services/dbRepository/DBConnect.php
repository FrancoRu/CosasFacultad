<?php

interface DatabaseInterface
{
  public function connect();
}

class MySQLDatabase implements DatabaseInterface
{
  private $server;
  private $username;
  private $password;
  private $database;
  private $port;

  public function __construct()
  {
    $this->server = $_ENV['SERVER'];
    $this->username = $_ENV['USER'];
    $this->password = $_ENV['PASSWORD'];
    $this->database = $_ENV['DATABASE'];
    $this->port = $_ENV['PORT'];
  }

  public function connect()
  {
    try {
      $conn = new mysqli($this->server, $this->username, $this->password, $this->database, $this->port);
      return $conn;
    } catch (Exception $e) {
      die('Connection failed: ' . $e->getMessage());
    }
  }
}

class DBManagerFactory
{
  private static $instance;

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new self();
    }
    return self::$instance;
  }

  public function createDatabase()
  {
    return new MySQLDatabase();
  }
}
