<?php
	$app->get('/picture/',function() use($app){
		try {
			$conex = getConexion();
			$result = $conex->prepare("SELECT * FROM alumno ORDER BY id DESC");		
			$result->execute();
			$us = $result->fetchAll(PDO::FETCH_OBJ);
			$app->response->headers->set('Content-type','application/json');
			$app->response->status(200);
			$app->response->body(json_encode($us));
			$conex = null;
		}catch(PDOException $e) {
			echo 'Error: '.$e->getMessage();
		}
	});

	/*Create*/
	$app->post("/alumnos/",function() use($app) {
		$vObj = json_decode(file_get_contents("php://input"));
		$nombre = $vObj->nombre;
		$carrera = $vObj->carrera;
		$genero = $vObj->genero;
		$fecha = $vObj->fecha;

		try {
			$conex = getConexion();
			$result = $conex->prepare("INSERT INTO alumno VALUES (null,'$nombre','$carrera',$genero,'$fecha')");
			$result->execute();
			$res = $result->rowCount();
			$conex = null;
			$app->response->headers->set("Content-type","application/json");
			$app->response->status(200);
			$app->response->body(json_encode($res));

		}catch(PDOException $e) {
			echo "Error: ".$e->getMessage();
		}


	});
	/*Update*/

	$app->put("/alumnos/",function() use($app) {
		$vObj = json_decode(file_get_contents("php://input"));
		$nombre = $vObj->nombre;
		$carrera = $vObj->carrera;
		$genero = $vObj->genero;
		$fecha = $vObj->fecha;
		$id = $vObj->id;

		try {
			$conex = getConexion();
			$result = $conex->prepare("UPDATE alumno SET nombre='$nombre',carrera='$carrera',genero=$genero,fecha='$fecha' WHERE id=$id");

			$result->execute();
			$res = $result->rowCount();
			$conex = null;
			$app->response->headers->set("Content-type","application/json");
			$app->response->status(200);
			$app->response->body(json_encode($res));

		}catch(PDOException $e) {
			echo "Error: ".$e->getMessage();
		}
	});

	/*Delete*/
	$app->delete("/alumnos/:id",function($id) use($app) {
		try {
			$conex = getConex();
			$result = $conex->prepare("DELETE FROM alumno WHERE id=?");
			$result->bindParam(1,$id);

			$result->execute();
			$conex = null;

			$app->response->headers->set("Content-type","application/json");
			$app->response->headers->set('Access-Control-Allow-Origin','*');
			$app->response->status(200);
			$app->response->body(json_encode(array('success'=>'correct')));

		}catch(PDOException $e) {
			echo "Error: ".$e->getMessage();
		}
	});
?>