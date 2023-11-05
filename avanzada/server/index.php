<?php
require 'vendor/autoload.php';
require_once './controllers/userController.php';
$dotenv = Dotenv\Dotenv::createImmutable(__DIR__);
$dotenv->safeLoad();
session_start();

require_once 'router.php';
