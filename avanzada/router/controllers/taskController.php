<?php
require_once 'server/../services/taskService.php';
require_once 'server/../models/taskViewModel.php';

class TaskController
{
  private static $instance;
  private $taskService;
  private $tag;

  private function __construct()
  {
    $this->taskService = TaskService::getInstance();
    $this->tag = TagService::getInstance();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new TaskController();
    }
    return self::$instance;
  }

  public function createTask($args)
  {
    $taskData = new TaskViewModel($args);

    if (!$taskData->isValid()) {
      return $this->errorResponse("Datos no validos");
    }

    $result = $this->taskService->createTask(get_object_vars($taskData));
    return $this->successResponse($result);
  }

  public function modifyTask($args)
  {
    $taskData = new TaskViewModel($args);

    if (!$taskData->isValid()) {
      return $this->errorResponse("Datos no validos");
    }

    $result = $this->taskService->modifyTask(get_object_vars($taskData));
    return $this->successResponse($result);
  }

  public function deleteTask($args)
  {
    $taskData = new TaskViewModel(['task_id' => $args['task_id']]);

    if ($taskData->validateTaskId()) {
      $result = $this->taskService->deleteTask([$args['task_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Falta 'task_id' en la request o el dato es invalido");
  }

  public function getTask($args)
  {
    $taskData = new TaskViewModel(['task_id' => $args['task_id']]);

    if ($taskData->validateTaskId()) {
      $result = $this->taskService->getTask([$args['task_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Falta 'task_id' en la request o el dato es invalido");
  }

  public function getAllTasks($args)
  {
    $taskData = new TaskViewModel(['project_id' => $args['project_id']]);
    if ($taskData->validateProjectId()) {
      $result = $this->taskService->getAllTasks([$args['project_id']]);
      $this->successResponse($result);
    }

    return $this->errorResponse("Falta 'project_id' en la request o el dato es invalido");
  }

  private function successResponse($data)
  {
    http_response_code(200);
    return $this->jsonResponse($data);
    exit();
  }

  private function errorResponse($message)
  {
    http_response_code(400);
    return $this->jsonResponse(["errorCode" => 400, "message" => $message]);
    exit();
  }

  private function jsonResponse($data)
  {
    return json_encode($data, JSON_UNESCAPED_UNICODE);
  }
}
