<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/trabajo',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM trabajo;");
		
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

$app->get('/trabajo/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM trabajo as t,empresa as e WHERE t.id_empresa=e.id AND e.id='$id';");

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

$app->post("/trabajo/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_empresa = $objDatos->id_empresa;
	$name = $objDatos->name;
	$detail = $objDatos->detail;
	$salary = $objDatos->salary;
	$fec_in = $objDatos->fec_in;
	$fec_lim = $objDatos->fec_lim;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertTrabajo('$id_empresa','$name','$detail','$salary','$fec_in','$fec_lim');");

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

$app->put("/trabajo/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$id_empresa = $objDatos->id_empresa;
	$name = $objDatos->name;
	$detail = $objDatos->detail;
	$salary = $objDatos->salary;
	$fec_in = $objDatos->fec_in;
	$fec_lim = $objDatos->fec_lim;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE trabajo SET id_empresa='$id_empresa',name='$name',detail='$detail',salary='$salary',fec_in='$fec_in',fec_lim='$fec_lim' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'')));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/trabajo/:id',function($id) use($app) {
	try {
		$conex = getConex();
		$result = $conex->prepare("DELETE FROM trabajo WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode(array('id'=>$id,'error'=>'success')));

	} catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
