<?php
class TaskViewModel
{
  public $project_id;
  public $task_id;
  public $task_name;
  public $task_desc;
  public $task_priority;
  private $error; // Mantener privado para no enviar a la base de datos.

  public function __construct($args = [])
  {
    $this->project_id = $args['project_id'] ?? null;
    $this->task_id = $args['task_id'] ?? null;
    $this->task_name = $args['task_name'] ?? null;
    $this->task_desc = $args['task_description'] ?? null;
    $this->task_priority = $args['task_priority'] ?? null;
  }

  public function isValid()
  {
    if (
      $this->validateProjectId() &&
      $this->validateTaskName() &&
      $this->validateTaskId()
    ) {
      return true;
    }

    return false;
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

  public function validateProjectId()
  {
    if (!is_string($this->project_id) || !preg_match('/^[0-9a-fA-F]{32}$/', $this->project_id)) {
      $this->error = $this->createError('Invalid project_id format');
      return false;
    }

    return true;
  }

  public function validateTaskId()
  {
    if (!is_string($this->task_id) || !preg_match('/^[0-9a-fA-F]{32}$/', $this->task_id)) {
      $this->error = $this->createError('Invalid task_id format');
      return false;
    }

    return true;
  }

  public function validateTaskName()
  {
    if (!is_string($this->task_name)) {
      $this->error = $this->createError('Task_name should be a string');
      return false;
    }

    return true;
  }
}
