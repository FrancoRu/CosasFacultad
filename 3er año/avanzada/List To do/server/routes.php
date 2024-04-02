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
  '/tasks/all' => ['GET' => 'taskController@getAllTasks'],
  '/tasks/create' => ['POST' => 'taskController@create'],
  '/tasks/edit' => ['POST' => 'taskController@update'],
  '/tasks/delete' => ['POST' => 'taskController@delete'],
  '/tasks' => ['GET' => 'taskController@getTask'],
];
