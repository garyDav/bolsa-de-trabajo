(function(angular) {

	'use strict';
	angular.module('categoriaModule').controller('categoriaCtrl',['$scope','categoriaService','$routeParams','funcionesService','trabajoCategoriaService','upload',
		function($scope,categoriaService,$routeParams,funcionesService,trabajoCategoriaService,upload) {
			$scope.mensaje = '';
			$scope.data = [];
			$scope.dataCategoria = [];

			$scope.find = function() {
				var f = new Date();
				var dia = ''+f.getDate();
				var mes = ''+(f.getMonth() +1);
				if( dia.length == 1 ) {
					dia = '0'+dia;
				}
				if( mes.length == 1 ) {
					mes = '0'+mes;
				}
				var ahora = f.getFullYear() + "-" + mes + "-" + dia;
				var obj = trabajoCategoriaService.getTrabajoCate($routeParams.id);
				//console.log(obj);
				obj.then(
					function(response) {
						var cont = 0;
						response.data.forEach(function(element,index,array) {
							console.log(funcionesService.fechaLimMayor(element.fec_lim, ahora));
							console.log('fecha limite '+element.fec_lim);
							console.log('ahora '+ahora);
							if( funcionesService.fechaLimMayor(element.fec_lim, ahora) ) {
								//response.data.splice(index,1);
								element.fec = funcionesService.timeVerbal(element.fec);
								element.fec_in = funcionesService.fecha(element.fec_in);
								element.fec_lim = funcionesService.fecha(element.fec_lim);
								$scope.data.push(element);
							}
						});
						console.log($scope.data);
					},function(response) {
						console.log(response);
					}
				);
				
			};
			
			$scope.findCategoria = function() {
				var obj = categoriaService.query();
				obj.$promise.then(function(response){
					$scope.dataCategoria = response;
					console.log($scope.dataCategoria);
				},function(response){
					console.log(response);
				});
			};

			$scope.save = function(newObj) {
				var logo = '';
				var msg = '';
				upload.saveImg($scope.file).then(function(response) {
					console.log(response);
					if(response) {
						logo = response.src;
						msg = response.msg;
						newObj.logo = logo;

						var obj = new categoriaService(newObj);
						obj.$save(function(response) {
							var newData = {
								id: response.id,
								name: newObj.name,
								logo: newObj.logo
							};
							console.log(response);
							if( response.error == 'success' ) {
								$scope.mensaje = 'Registro insertado correctamente e '+msg;
								$scope.dataCategoria.push(newData);
							} else {
								$scope.mensaje = response.error;
							}
							console.log($scope.dataCategoria);
						},function(response) {
							console.log(response);
						});
						console.log(newObj);
					}
				});
				$scope.newObj = {};
			};
			$scope.cancel = function() {
				$scope.newObj = {};
			};
			$scope.delete = function(id) {
				//console.log('eliminar ID: '+id);
				var remove = confirm('¿Está seguro de eliminar el registro?');
				if( remove ) {
					var obj = new categoriaService({id:id});
					obj.$remove(function(response) {
						console.log(response);
						for(var d in $scope.dataCategoria) {
							if( $scope.dataCategoria[d].id === id ) {
								$scope.dataCategoria.splice(d,1);
							}
						}
					},
					function(response) {
						console.log(response);
					});
				}
			};
		}
	]);


})(window.angular);