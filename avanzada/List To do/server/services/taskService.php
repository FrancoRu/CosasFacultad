<?php
require_once 'services/../dbRepository/DBService.php';
class TaskService
{
  private $dbInstance;
  private static $instance;
  private function __construct()
  {
    $this->dbInstance = DBService::getInstance();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new self();
    }
    return self::$instance;
  }

  public function createTask($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_CREATE_TASK'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      }
      return false;
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }

  public function modifyTask($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_SEARCH_TASK'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      }
      return false;
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }

  public function deleteTask($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_DELETE_TASK'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      }
      return false;
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }

  public function getTask($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_GET_BY_ID_TASK'], [...$args]);
      if ($result->num_rows > 0) {
        return $result->fetch_assoc();
      }
      return false;
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }

  public function getAllTasks($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_GET_BY_ID_ALL_TASK'], [...$args]);
      if ($result->num_rows > 0) {
        return $result->fetch_assoc();
      }
      return false;
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }
}
