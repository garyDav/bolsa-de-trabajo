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

require 'models/Combinaciones.php';
require 'models/Categoria.php';
require 'models/Departamento.php';
require 'models/Empresa.php';
require 'models/Sucursal.php';
require 'models/Trabajo.php';
require 'models/User.php';
//end EntidadesRESTFULL

$app->run();



?>

