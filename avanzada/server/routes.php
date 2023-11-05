<?php
return [
  '/server/' => ['GET' => 'UserController@isLoggedIn'],
  '/server/login' => ['POST' => 'UserController@logIn'],
  '/server/signup' => ['POST' => 'UserController@signUp'],
  '/server/projects' => ['GET' => 'ProjectController@getAllProjects'],
  '/server/projects/create' => ['POST' => 'ProjectController@create'],
  '/server/projects/edit/{id}' => ['POST' => 'ProjectController@update'],
  '/server/projects/delete/{id}' => ['POST' => 'ProjectController@delete'],
  '/server/projects/{id}' => ['GET' => 'ProjectController@getProject'],
  '/server/tasks' => ['GET' => 'TaskController@getAllTasks'],
  '/server/tasks/create' => ['POST' => 'TaskController@create'],
  '/server/tasks/edit/{id}' => ['POST' => 'TaskController@update'],
  '/server/tasks/delete/{id}' => ['POST' => 'TaskController@delete'],
  '/server/tasks/{id}' => ['GET' => 'TaskController@getTask'],
];
