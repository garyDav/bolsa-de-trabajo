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
require 'models/Departamento.php';
require 'models/Empleado.php';
require 'models/Empleador.php';
require 'models/Mensaje.php';
//end EntidadesRESTFULL

$app->run();



?>

