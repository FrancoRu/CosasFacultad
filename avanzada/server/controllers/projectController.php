<?php
require_once 'php/../services/projectService.php';
require_once 'php/../models/projectViewModel.php';

class ProjectController
{
  private static $instance;
  private $projectService;

  private function __construct()
  {
    $this->projectService = ProjectService::getInstance();
  }

  public static function getInstance()
  {
    if (self::$instance === null) {
      self::$instance = new ProjectController();
    }
    return self::$instance;
  }

  public function createProject()
  {
    $projectData = new ProjectViewModel($_POST);

    if (!$projectData->isValid()) {
      return $this->errorResponse("Data not valid");
    }

    $result = $this->projectService->createProject(get_object_vars($projectData));
    return $this->successResponse($result);
  }

  public function modifyProject()
  {
    $projectData = new ProjectViewModel($_POST);

    if (!$projectData->isValid()) {
      return $this->errorResponse("Data not valid");
    }

    $result = $this->projectService->modifyProject(get_object_vars($projectData));
    return $this->successResponse($result);
  }

  public function deleteProject()
  {
    $projectData = new ProjectViewModel(['project_id' => $_POST['project_id']]);

    if ($projectData->validateProjectId($_POST['project_id'])) {
      $result = $this->projectService->deleteProject([$_POST['project_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Invalid or missing 'project_id' in request");
  }

  public function getProject()
  {
    $projectData = new ProjectViewModel(['project_id' => $_POST['project_id']]);

    if ($projectData->validateProjectId()) {
      $result = $this->projectService->getProject([$_POST['project_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Invalid or missing 'project_id' in request");
  }

  public function getAllProjects()
  {
    $projectData = new ProjectViewModel(['project_userId' => $_POST['project_userId']]);

    if ($projectData->validateUserId()) {
      $result = $this->projectService->getAllProject([$_POST['project_userId']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Invalid or missing 'project_userId' in request");
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
