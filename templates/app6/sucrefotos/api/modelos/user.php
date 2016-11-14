<?php
$app->get('/user/all',function() use($app) {
	try {
		$conex = getConexion();

		$result = $conex->prepare("SELECT * FROM user WHERE status = 1");
		
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
$app->get('/user/all/inverse',function() use($app) {
	try {
		$conex = getConexion();

		$result = $conex->prepare("SELECT * FROM user WHERE status = 1 ORDER BY user_id DESC");
		
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
$app->get('/user/:id',function($id) use($app) {
	try {
		$conex = getConexion();

		$result = $conex->prepare("SELECT * FROM user WHERE user_id='$id' AND status = 1;");

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

$app->post("/user",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$username = $objDatos->username;
	$name = $objDatos->name;
	$email = $objDatos->email;
	$password = $objDatos->password;

	try {
		$conex = getConexion();

		$salt = '#/$02.06$/#_#/$25.10$/#';
		$password = md5($salt.$password);
		$password = sha1($salt.$password);

		$result = $conex->prepare("INSERT INTO user VALUES (NULL, '', '$username', '$name', '', '$email', '$password', NOW(), '1');");

		$result->execute();
		$res = $result->rowCount();
		$conex = null;

		$app->response->headers->set("Content-type","application/json");
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode($res));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
});

$app->put("/user/:id",function($id) use($app) {
	//$objDatos = json_decode(file_get_contents("php://input"));
	$jsonmessage = \Slim\Slim::getInstance()->request();
  	$objDatos = json_decode($jsonmessage->getBody());

	$username = $objDatos->username;
	$name = $objDatos->name;
	$email = $objDatos->email;
	$password = $objDatos->password;
	$url_perfil = $objDatos->url_perfil;

	try {
		$conex = getConexion();
		$result = $conex->prepare("UPDATE user SET username='$username',name='$name',url_perfil='$url_perfil',email='$email',password='$password' WHERE user_id='$id';");

		$result->execute();
		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->status(200);
		$app->response->body(json_encode([array('error'=>'success','see'=>$objDatos)]));

	}catch(PDOException $e) {
		echo "Error: ".$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));

$app->delete('/user/:id',function($id) use($app) {
	$status = 0;
	try {
		$conex = getConexion();

		$result = $conex->prepare("UPDATE user SET status=$status WHERE user_id='$id';");
		$result->execute();

		$conex = null;

		$app->response->headers->set('Content-type','application/json');
		$app->response->headers->set('Access-Control-Allow-Origin','*');
		$app->response->status(200);
		$app->response->body(json_encode(array('error'=>'success')));
	}catch(PDOException $e) {
		echo 'Error: '.$e->getMessage();
	}
})->conditions(array('id'=>'[0-9]{1,11}'));
$app->post("/login/",function() use($app) {
	$objDatos = json_decode(file_get_contents("php://input"));

	$c = $objDatos->correo;
	$pwd = $objDatos->pwd;

	try {
		$conex = getConexion();

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