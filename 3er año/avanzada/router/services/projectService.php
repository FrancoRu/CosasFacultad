<?php

namespace App\Services;

use App\Services\BD\DBService;
use Exception;

class ProjectService
{
  private $dbInstance;
  private $instance;
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

  public function createProject($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_CREATE_PROJECT'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      } else {
        return null;
      }
    } catch (Exception $e) {
      return $e->getMessage(); // Maneja la excepción de manera adecuada
    }
  }

  public function modifyProject($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_MODIFY_PROJECT'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      } else {
        return null;
      }
    } catch (Exception $e) {
      return $e->getMessage($args);
    }
  }

  public function deleteProject($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_DELETE_PROJECT'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      } else {
        return null;
      }
    } catch (Exception $e) {
      return $e->getMessage($args);
    }
  }

  public function assignTaskToProject($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_ASSIGN_TASK_TO_PROJECT'], [...$args]);
      if ($result->num_rows > 0) {
        return true;
      } else {
        return null;
      }
    } catch (Exception $e) {
      return $e->getMessage($args);
    }
  }

  public function getProject($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_PROJECT_GET_BY_ID'], [...$args]);
      if ($result->num_rows > 0) {
        return $result->fetch_assoc();
      } else {
        return array();
      }
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }

  public function getAllProject($args)
  {
    try {
      $result = $this->dbInstance->executeQuery($_ENV['QUERY_PROJECT_GET_ALL_BY_USER'], [...$args]);
      if ($result->num_rows > 0) {
        // $newArray = array();
        // while ($row = $result->fetch_assoc()) {
        //   $newArray[] = $row;
        // }
        return $result->fetch_assoc();
      } else {
        return array();
      }
    } catch (Exception $e) {
      return $e->getMessage();
    }
  }
}
