<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/publicar',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT p.id,p.work,p.name,p.age,p.email,p.cell,p.detail,p.fec,d.name as depa FROM publicar as p,departamento as d WHERE p.id_departamento = d.id;");
		
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

$app->post("/publicar/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$id_departamento = $objDatos->id_departamento;
	$work = $objDatos->work;
	$name = $objDatos->name;
	$age = $objDatos->age;
	$email = $objDatos->email;
	$cell = $objDatos->cell;
	$detail = $objDatos->detail;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertPublicar('$id_departamento','$work','$name','$age','$email','$cell','$detail');");

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

?>