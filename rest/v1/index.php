<?php
//Libreria de Slim
require '../vendor/Slim/Slim.php';
//end Libreria.

\Slim\Slim::registerAutoloader();

$app = new \Slim\Slim();

session_start();

define('SPECIALCONSTANT',true);

//EntidadesRESTFULL
require 'models/connect.php';

require 'models/Categoria.php';
//end EntidadesRESTFULL

$app->run();



?>

