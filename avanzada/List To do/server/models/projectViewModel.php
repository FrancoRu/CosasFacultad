<?php
class ProjectViewModel
{
  public $project_id;
  public $project_userId;
  public $project_name;
  public $project_description;
  private $error; // Mantener privado para no enviar a la base de datos.

  public function __construct($args = [])
  {
    $this->project_id = $args['project_id'] ?? null;
    $this->project_userId = $args['project_userId'] ?? null;
    $this->project_name = $args['project_name'] ?? null;
    $this->project_description = $args['project_description'] ?? null;
  }

  public function isValid()
  {
    if (
      $this->validateProjectId() &&
      $this->validateUserId() &&
      $this->validateProjectName() &&
      $this->validateProjectDescription()
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
      $this->error = $this->createError('project_id formato invalido');
      return false;
    }

    return true;
  }

  public function validateUserId()
  {
    if (!is_string($this->project_userId) || !preg_match('/^[0-9a-fA-F]{32}$/', $this->project_userId)) {
      $this->error = $this->createError('user_id formato invalido');
      return false;
    }

    return true;
  }

  public function validateProjectName()
  {
    if (!is_string($this->project_name)) {
      $this->error = $this->createError('Project_name debe ser un string');
      return false;
    }

    return true;
  }

  public function validateProjectDescription()
  {
    if (!is_string($this->project_description)) {
      $this->error = $this->createError('Project_description debe ser un string');
      return false;
    }

    return true;
  }
}
