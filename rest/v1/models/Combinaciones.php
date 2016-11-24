<?php if(!defined('SPECIALCONSTANT')) die(json_encode([array('id'=>'0','nombre'=>'Acceso Denegado')]));

$app->get('/trabajo/empresa/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT t.id,t.name,t.detail,t.salary,t.fec,t.fec_in,t.fec_lim,e.photo FROM trabajo as t,empresa as e WHERE t.id_empresa=e.id AND e.id='$id';");

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

$app->get('/trabajo/categoria/:id',function($id) use($app) {
	try {
		$conex = getConex();

		$result = $conex->prepare("SELECT t.id,t.name,t.detail,t.salary,t.fec,t.fec_in,t.fec_lim,e.photo FROM trabajo as t,empresa as e,categoria as c WHERE t.id_empresa=e.id AND e.id_categoria=c.id AND c.id='$id';");

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

