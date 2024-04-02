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

  public function createProject($args)
  {
    $projectData = new ProjectViewModel($args);

    if (!$projectData->isValid()) {
      return $this->errorResponse("Datos no válidos");
    }

    $result = $this->projectService->createProject(get_object_vars($projectData));
    return $this->successResponse($result);
  }

  public function modifyProject($args)
  {
    $projectData = new ProjectViewModel($args);

    if (!$projectData->isValid()) {
      return $this->errorResponse("Datos no válidos");
    }

    $result = $this->projectService->modifyProject(get_object_vars($projectData));
    return $this->successResponse($result);
  }

  public function deleteProject($args)
  {
    $projectData = new ProjectViewModel(['project_id' => $args['project_id']]);

    if ($projectData->validateProjectId($args['project_id'])) {
      $result = $this->projectService->deleteProject([$args['project_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Falta 'project_id 'en la request o el dato es inválido");
  }

  public function getProject($args)
  {
    $projectData = new ProjectViewModel(['project_id' => $args['project_id']]);

    if ($projectData->validateProjectId()) {
      $result = $this->projectService->getProject([$args['project_id']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Falta 'project_id' en la request o el dato es inválido");
  }

  public function getAllProjects($args)
  {
    $projectData = new ProjectViewModel(['project_userId' => $args['project_userId']]);

    if ($projectData->validateUserId()) {
      $result = $this->projectService->getAllProject([$args['project_userId']]);
      return $this->successResponse($result);
    }

    return $this->errorResponse("Falta 'project_userId' en la request o el dato es inválido");
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
