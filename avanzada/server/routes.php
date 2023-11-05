<?php
return [
  '/' => ['GET' => 'HomeController@index'],
  '/login' => ['POST' => 'UserController@login'],
  '/register' => ['POST' => 'UserController@register'],
  '/projects' => ['GET' => 'ProjectController@index'],
  '/projects/create' => ['POST' => 'ProjectController@create'],
  '/projects/edit' => ['POST' => 'ProjectController@update'],
  '/projects/delete' => ['POST' => 'ProjectController@delete'],
  '/tasks' => ['GET' => 'TaskController@index'],
  '/tasks/create' => ['POST' => 'TaskController@create'],
  '/tasks/edit' => ['GET' => 'TaskController@edit', 'POST' => 'TaskController@update'],
  '/tasks/delete' => ['POST' => 'TaskController@delete'],
];
