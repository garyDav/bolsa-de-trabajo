<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/sucursal',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM sucursal;");
		
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

$app->get('/sucursal/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM sucursal WHERE id='$id';");

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

$app->post("/sucursal/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_empresa = $objDatos->id_empresa;
	$id_departamento = $objDatos->id_departamento;
	$name = $objDatos->name;
	$address = $objDatos->address;
	$phone = $objDatos->phone;
	$cell = $objDatos->cell;


	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertSucursal('$id_empresa','$id_departamento','$name','$address','$phone','$cell');");

		$result->execute();
		$res = $result->fetchObject();

		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});

$app->put("/sucursal/:id",function($id) use($app) {
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$id_empresa = $objDatos->id_empresa;
	$id_departamento = $objDatos->id_departamento;
	$name = $objDatos->name;
	$address = $objDatos->address;
	$phone = $objDatos->phone;
	$cell = $objDatos->cell;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE sucursal SET id_empresa='$id_empresa',id_departamento='$id_departamento',name='$name',address='$address',phone='$phone',cell='$cell', WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/sucursal/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE FROM sucursal WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
