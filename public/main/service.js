(function(angular) {

	angular.module('mainModule').factory('categoriaService',['$resource',
		function($resource) {
			return $resource('rest/v1/categoria/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

	angular.module('mainModule').factory('loginService',function ($http,$location,sessionService,$rootScope) {
		return {
			login: function(user,scope) {
				var $promise = $http.post('rest/v1/login',user);
				$promise.then(function(res){
					console.log(res);
					var uid = res.data.error;
					if(uid == 'success') {
						//scope.msgtxt = 'Correct Information';
						sessionService.set('user','admin');
						$rootScope.c_admin = true;
						sessionService.set('userId',res.data.id);
						$location.path('/usuario/'+res.data.id);
					} else {
						scope.msgtxt = 'Error Information';
						$location.path('/ingresar');
					}
				});
			},
			lougout: function() {
				sessionService.destroy('user');
				$rootScope.c_admin = false;
				$location.path('/ingresar');
			}, isLogged: function() {
				if( sessionService.get('user') )
					return true;
				else
					return false;
			}
		};
	});

	angular.module('mainModule').factory('sessionService',function ($http) {
		return {
			set: function(key,value) {
				return localStorage.setItem(key,value);
			},
			get: function(key) {
				return localStorage.getItem(key);
			},
			destroy: function(key) {
				return localStorage.removeItem(key);
			}
		};
	});

	angular.module('mainModule').factory('funcionesService',function () {
		return {
			convertCadFecha: function(cad) {
				var long = cad.length;
				var año = cad.substring(long-4, long);
				var aux = cad.split(',',1);
				var vec = cad.split(' ',2);
				var dia = vec[0];
				var cadMes = vec[1].substring(0,vec[1].length-1);
				var mes = '';
				switch(cadMes) {
					case 'January':
						mes = '01';
						break;
					case 'February':
						mes = '02';
						break;
					case 'March':
						mes = '03';
						break;
					case 'April':
						mes = '04';
						break;
					case 'May':
						mes = '05';
						break;
					case 'June':
						mes = '06';
						break;
					case 'July':
						mes = '07';
						break;
					case 'August':
						mes = '08';
						break;
					case 'September':
						mes = '09';
						break;
					case 'October':
						mes = '10';
						break;
					case 'November':
						mes = '11';
						break;
					case 'December':
						mes = '12';
						break;
				}
				if( dia.length == 1 ) {
					dia = '0'+dia;
				}
				
				return año+'/'+mes+'/'+dia;
			},
			timeVerbal: function(fecha) {
				var tiempo = new Date();
				var cadena = fecha.substr(8,2)+" de ";
			 	var mes = parseInt(fecha.substr(5,2));
			 		switch(mes){
			 			case 1:cadena+="Enero";break;
			 			case 2:cadena+="Febrero";break;
			 			case 3:cadena+="Marzo";break;
			 			case 4:cadena+="Abril";break;
			 			case 5:cadena+="Mayo";break;
			 			case 6:cadena+="Junio";break;
			 			case 7:cadena+="Julio";break;
			 			case 8:cadena+="Agosto";break;
			 			case 9:cadena+="Septiembre";break;
			 			case 10:cadena+="Octubre";break;
			 			case 11:cadena+="Noviembre";break;
			 			case 12:cadena+="Diciembre";break;
			 			default:break;
			 		}
			 	if(""+tiempo.getUTCFullYear() !== fecha.substr(0,4)){
			 		cadena += " del "+fecha.substr(0,4);
			 	}
			 	if(fecha.substr(8,2) === ""+tiempo.getDate()){
					cadena = "Hoy ";
				}
				else if(fecha.substr(8,2) === ""+(tiempo.getDate()-1)){
					cadena = "Ayer ";
				}
			 	if((parseInt(fecha.substr(11,2))>=12)){
			 		cadena += " a las "+fecha.substr(11,5)+" PM";
			 	}
			 	else{
			 		cadena += " a las "+fecha.substr(11,5)+" AM";
			 	}
			 	return cadena;
			},
			fecha: function(fecha) {
				var tiempo = new Date();
				var cadena = fecha.substr(8,2)+" de ";
			 	var mes = parseInt(fecha.substr(5,2));
			 		switch(mes){
			 			case 1:cadena+="Enero";break;
			 			case 2:cadena+="Febrero";break;
			 			case 3:cadena+="Marzo";break;
			 			case 4:cadena+="Abril";break;
			 			case 5:cadena+="Mayo";break;
			 			case 6:cadena+="Junio";break;
			 			case 7:cadena+="Julio";break;
			 			case 8:cadena+="Agosto";break;
			 			case 9:cadena+="Septiembre";break;
			 			case 10:cadena+="Octubre";break;
			 			case 11:cadena+="Noviembre";break;
			 			case 12:cadena+="Diciembre";break;
			 			default:break;
			 		}
			 	if(""+tiempo.getUTCFullYear() !== fecha.substr(0,4)){
			 		cadena += " del "+fecha.substr(0,4);
			 	}
			 	if(fecha.substr(8,2) === ""+tiempo.getDate()){
					cadena = "Hoy ";
				}
				else if(fecha.substr(8,2) === ""+(tiempo.getDate()-1)){
					cadena = "Ayer ";
				}
			 	return cadena;
			},
			hora: function(fecha) {
				var tiempo = new Date();
				var cadena = '';
			 	if((parseInt(fecha.substr(11,2))>=12)){
			 		cadena += fecha.substr(11,5)+" PM";
			 	}
			 	else{
			 		cadena += fecha.substr(11,5)+" AM";
			 	}
			 	return cadena;
			},
			fechaLimMayor: function(fechaLim,fechaAhora) {
				if( fechaLim >= fechaAhora ) {
					return true;
				}
				return false;
			}
		};
	});

	angular.module('mainModule').service('upload',['$http','$q',function($http,$q) {
		this.saveImg = function(img) {
			console.log(img);
			var deferred = $q.defer();
			var formData = new FormData();
			formData.append('img',img);
			$http.post('data/server.php',formData, {
				headers: {
					'Content-Type': undefined
				}
			}).success(function(response){
				deferred.resolve(response);
			}).error(function(msg, code){
				deferred.reject(msg);
			});
			return deferred.promise;
		};
	}]);
	angular.module('mainModule').service('upload2',['$http','$q',function($http,$q) {
		this.saveImg = function(img) {
			console.log(img);
			var deferred = $q.defer();
			var formData = new FormData();
			formData.append('img',img);
			$http.post('data/server2.php',formData, {
				headers: {
					'Content-Type': undefined
				}
			}).success(function(response){
				deferred.resolve(response);
			}).error(function(msg, code){
				deferred.reject(msg);
			});
			return deferred.promise;
		};
	}]);


})(window.angular);
