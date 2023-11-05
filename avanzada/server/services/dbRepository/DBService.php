<?php

require_once 'DBConnect.php';
class DBService
{
  private static $instance;
  private $stmt;
  private $db;

  private function __construct()
  {
    $this->db = DBManagerFactory::getInstance()->createDatabase();
    $this->stmt = $this->db->connect();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new self();
    }
    return self::$instance;
  }

  public function prepareStmt($query)
  {
    return $this->stmt->prepare($query);
  }

  public function cleanParam(array $args)
  {
    $newArgs = array();
    foreach ($args as $arg) {
      $newArgs[] = mysqli_real_escape_string($this->stmt, $arg);
    }
    return $newArgs;
  }
  private function transformArray($args)
  {
    $newArray = array();
    foreach ($args as $arg) {
      $newArray[] = $arg;
    }
    return $newArray;
  }

  private function mapTypes($arg)
  {
    switch ($arg) {
      case 'project_id':
        return 'i';
    }
  }

  public function executeQuery($query, $args)
  {
    try {
      $cleanedArgs = $this->cleanParam($args); // Debe pasarse un array de valores
      $values = $this->transformArray($cleanedArgs);
      $statement = $this->prepareStmt($query);
      $types = str_repeat('s', count($cleanedArgs));
      array_unshift($values, $types);
      $statement->bind_param(...$values);
      $statement->execute();
      return $statement->get_result();
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }
}
