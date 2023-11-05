<?php
require_once 'php/../services/taskService.php';
require_once 'php/../models/taskViewModel.php';

class TaskController
{
  private static $instance;
  private $taskService;

  private function __construct()
  {
    $this->taskService = TaskService::getInstance();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new TaskController();
    }
    return self::$instance;
  }

  public function createTask()
  {
    $taskData = new TaskViewModel($_POST);

    if (!$taskData->isValid()) {
      return $this->errorResponse("Data not valid");
    }

    $result = $this->taskService->createTask(get_object_vars($taskData));
    return $this->successResponse($result);
  }

  public function modifyTask()
  {
    $taskData = new TaskViewModel($_POST);

    if (!$taskData->isValid()) {
      return $this->errorResponse("Data not valid");
    }

    $result = $this->taskService->modifyTask(get_object_vars($taskData));
    return $this->successResponse($result);
  }

  public function deleteTask()
  {
    $taskData = new TaskViewModel(['task_id' => $_POST['task_id']]);

    if ($taskData->validateTaskId()) {
      $result = $this->taskService->deleteTask([$_POST['task_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Missing 'task_id' in request");
  }

  public function getTask()
  {
    $taskData = new TaskViewModel(['task_id' => $_POST['task_id']]);

    if ($taskData->validateTaskId()) {
      $result = $this->taskService->getTask([$_POST['task_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Missing 'task_id' in request");
  }

  public function getAllTasks()
  {
    $taskData = new TaskViewModel(['project_id' => $_POST['project_id']]);

    if ($taskData->validateProjectId()) {
      $result = $this->taskService->getAllTasks([$_POST['project_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Missing 'project_id' in request");
  }

  private function successResponse($data)
  {
    http_response_code(200);
    return $this->jsonResponse($data);
  }

  private function errorResponse($message)
  {
    http_response_code(400);
    return $this->jsonResponse(["errorCode" => 400, "message" => $message]);
  }

  private function jsonResponse($data)
  {
    return json_encode($data, JSON_UNESCAPED_UNICODE);
  }
}
