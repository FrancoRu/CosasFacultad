<?php

require_once 'server/../services/tagService.php';
header('Content-Type: application/json');

header('Content-Type: text/html');
require 'server/../vendor/autoload.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->safeLoad();
session_start();

require_once 'router.php';
