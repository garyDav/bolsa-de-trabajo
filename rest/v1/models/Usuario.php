<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/usuarios',function() use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM usuario;");
		
		$result->execute();
		$us = $result->fetchAll(PDO::FETCH_OBJ);
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($us));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
});

$app->get('/usuarios/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT * FROM usuario WHERE id='$id';");

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

$app->post("/usuarios/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$name = $objDatos->name;
	$user = $objDatos->user;
	$email = $objDatos->email;
	$password = $objDatos->password;

	try {
		$conex = getConex();

		$result = $conex->prepare("CALL pInsertUsuario('$name','$user','$email','$password');");

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

$app->put("/usuarios/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$nom = $objDatos->nom;
	$ap = $objDatos->ap;
	$correo = $objDatos->correo;

	try {
		$conex = getConex();
		$result = $conex->prepare("UPDATE usuario SET nom='$nom',ap='$ap',correo='$correo' WHERE id='$id'");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode([array('error'=>'success','see'=>$objDatos)]));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->post("/login/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$c = $objDatos->correo;
	$pwd = $objDatos->pwd;

	try {
		$conex = getConex();

		$salt = '#/$02.06$/#_#/$25.10$/#';
		$pwd = md5($salt.$pwd);
		$pwd = sha1($salt.$pwd);

		$result = $conex->prepare("CALL pSession('$c','$pwd');");

		$result->execute();
		$res = $result->fetchObject();
		$uid = '';
		$id_user = '';
		$urlid_user = '';
		$nivel = '';
		if($res->error == 'success'){
			$_SESSION['uid'] = uniqid('ang_');
			$_SESSION['id_user'] = $res->id;
			$_SESSION['urlid_user'] = $res->urlid;
			$_SESSION['nivel'] = $res->nivel;
			$id_user = $_SESSION['id_user'];
			$uid = $_SESSION['uid'];
			$urlid_user = $_SESSION['urlid_user'];
			$nivel = $_SESSION['nivel'];
		}

		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		if($res->error == 'success')
			$app->response->body(json_encode(array('uid'=>$uid,'id'=>$id_user,'urlid'=>$urlid_user,'nivel'=>$nivel,'nom'=>$res->nom,'ap'=>$res->ap,'correo'=>$res->correo,'src'=>$res->src,'error'=>$res->error)));
		else
			$app->response->body(json_encode(array('uid'=>$uid,'id'=>$id_user,'urlid'=>$urlid_user,'nivel'=>$nivel,'error'=>$res->error)));
	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});

?>

