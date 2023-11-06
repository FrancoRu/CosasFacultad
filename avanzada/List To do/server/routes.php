<?php
return [
  '/' => ['GET' => 'userController@isLoggedIn'],
  '/home' => ['GET' => 'userController@isLoggedIn'],
  '/login' => ['POST' => 'userController@logIn'],
  '/signup' => ['POST' => 'userController@signUp'],
  '/logout' => ['GET' => 'userController@logOut'],
  '/projects' => ['GET' => 'ProjectController@getAllProjects'],
  '/projects/create' => ['POST' => 'ProjectController@create'],
  '/projects/edit/{id}' => ['POST' => 'ProjectController@update'],
  '/projects/delete/{id}' => ['POST' => 'ProjectController@delete'],
  '/projects/{id}' => ['GET' => 'ProjectController@getProject'],
  '/tasks' => ['POST' => 'taskController@getAllTasks'],
  '/tasks/create' => ['POST' => 'TaskController@create'],
  '/tasks/edit/{id}' => ['POST' => 'TaskController@update'],
  '/tasks/delete/{id}' => ['POST' => 'TaskController@delete'],
  '/tasks/{id}' => ['GET' => 'taskController@getTask'],
];
