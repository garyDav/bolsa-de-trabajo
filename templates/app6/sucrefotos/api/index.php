<?php
	require 'vendor/autoload.php';
	\Slim\Slim::registerAutoloader();

	$app = new \Slim\Slim();

	/*Modelos de la APP*/
	require "modelos/conexion.php";
	require "modelos/user.php";

	$app->run();
