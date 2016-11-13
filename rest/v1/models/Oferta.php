<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/oferta',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM oferta;");
		
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

$app->get('/oferta/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM oferta WHERE id='$id';");

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

$app->post("/oferta/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_categoria = $objDatos->id_categoria;
	$id_empleado = $objDatos->id_empleado;
	$id_empleador = $objDatos->id_empleador;
	$id_departamento = $objDatos->id_departamento;
	$detalle = $objDatos->detalle;
	$direccion = $objDatos->direccion;
	$latitud = $objDatos->latitud;
	$longitud = $objDatos->longitud;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertOferta('$id_categoria','$id_empleado','$id_empleador','$id_departamento','$detalle','$direccion','$latitud','$longitud');");

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

$app->put("/oferta/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$id_categoria = $objDatos->id_categoria;
	$id_empleado = $objDatos->id_empleado;
	$id_empleador = $objDatos->id_empleador;
	$id_departamento = $objDatos->id_departamento;
	$detalle = $objDatos->detalle;
	$direccion = $objDatos->direccion;
	$latitud = $objDatos->latitud;
	$longitud = $objDatos->longitud;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE oferta SET id_categoria='$id_categoria',id_empleado='$id_empleado',id_empleador='$id_empleador',id_departamento='$id_departamento',detalle='$detalle',direccion='$direccion',latitud='$latitud',longitud='$longitud' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/oferta/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE oferta WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
