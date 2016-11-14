<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/empleador',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM empleador;");
		
		$result->execute();
		$res = $result->fetchAll(PDO::FETCH_OBJ);
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});

$app->get('/empleador/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM empleador WHERE id='$id';");

		$result->execute();
		$res = $result->fetchObject();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});

$app->post("/empleador/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$foto = $objDatos->foto;
	$nombre = $objDatos->nombre;
	$apellido = $objDatos->apellido;
	$empresa = $objDatos->empresa;
	$correo = $objDatos->correo;
	$contra = $objDatos->contra;
	$telefono = $objDatos->telefono;
	$celular = $objDatos->celular;

	try {
		$conex = getConex();

		$salt = '#/$02.06$/#_#/$25.10$/#';
		$contra = md5($salt.$contra);
		$contra = sha1($salt.$contra);

		$result = $conex->prepare("CALL pInsertEmpleador('$foto','$nombre','$apellido','$empresa','$correo','$contra','$telefono','$celular');");

		$result->execute();
		$res = $result->fetchObject();
		//$res = array('response'=>'success');

		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
		//$app->response->body($ci);

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});

$app->put("/empleador/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$foto = $objDatos->foto;
	$nombre = $objDatos->nombre;
	$apellido = $objDatos->apellido;
	$empresa = $objDatos->empresa;
	$contra = $objDatos->contra;
	$telefono = $objDatos->telefono;
	$celular = $objDatos->celular;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE empleador SET foto='$foto',nombre='$nombre',apellido='$apellido',empresa='$empresa',contra='$contra',telefono='$telefono',celular='$celular' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/empleador/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE empleador WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));


$app->post("/login/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$correo = $objDatos->correo;
	$contra = $objDatos->contra;

	try {
		$conex = getConex();

		$salt = '#/$02.06$/#_#/$25.10$/#';
		$contra = md5($salt.$contra);
		$contra = sha1($salt.$contra);

		$result = $conex->prepare("CALL pSession('$correo','$contra');");

		$result->execute();
		$res = $result->fetchObject();
		//$res = array('response'=>'success');

		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));
		//$app->response->body($ci);

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});