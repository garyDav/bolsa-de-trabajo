<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/empresa',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT e.id,e.name,e.email,e.address,e.phone,e.cell,e.photo,e.detail,c.name as nameCate, c.logo FROM empresa as e,categoria as c WHERE e.id_categoria=c.id;");
		
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

$app->get('/empresa/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM empresa WHERE id='$id';");

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

$app->post("/empresa/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_categoria = $objDatos->id_categoria;
	$name = $objDatos->name;
	$email = $objDatos->email;
	$address = $objDatos->address;
	$phone = $objDatos->phone;
	$cell = $objDatos->cell;
	$photo = $objDatos->photo;
	$detail = $objDatos->detail;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertEmpresa('$id_categoria','$name','$email','$address','$phone','$cell','$photo','$detail');");

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

$app->put("/empresa/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$id_categoria = $objDatos->id_categoria;
	$name = $objDatos->name;
	$email = $objDatos->email;
	$address = $objDatos->address;
	$phone = $objDatos->phone;
	$cell = $objDatos->cell;
	$photo = $objDatos->photo;
	$detail = $objDatos->detail;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE empresa SET id_categoria='$id_categoria',name='$name',email='$email',address='$address',phone='$phone',cell='$cell',photo='$photo',detail='$detail' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/empresa/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE FROM empresa WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
