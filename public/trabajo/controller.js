(function(angular) {

	'use strict';
	angular.module('trabajoModule').controller('trabajoCtrl',['$scope','trabajoService','trabajoEmpresaService','$routeParams','funcionesService','empresaService',
		function($scope,trabajoService,trabajoEmpresaService,$routeParams,funcionesService,empresaService) {
			$scope.find = function() {
				$scope.data = [];
				var f = new Date();
				var ahora = f.getFullYear() + "-" + (f.getMonth() +1) + "-" + f.getDate();
				var obj = trabajoEmpresaService.getTrabajo($routeParams.id);
				//console.log(obj);
				obj.then(
					function(response) {
						console.log(response.data);
						var cont = 0;
						response.data.forEach(function(element,index,array) {
							if( funcionesService.fechaLimMayor(element.fec_lim, ahora) ) {
								//response.data.splice(index,1);
								element.fec = funcionesService.timeVerbal(element.fec);
								element.fec_in = funcionesService.fecha(element.fec_in);
								element.fec_lim = funcionesService.fecha(element.fec_lim);
								$scope.data.push(element);
							}
						});
						//$scope.data = response.data;
						console.log('Joder');
						console.log($scope.data);
					},function(response) {
						console.log(response);
					}
				);
			};

			$scope.findEmpresas = function() {
				var empresa = empresaService.query();
				empresa.$promise.then(
					function(response) {
						$scope.dataEmpresas = response;
						console.log($scope.dataEmpresas);
					},
					function(response) {}
				);
			};
			$scope.findTrabajo = function() {
				//$scope.data = [];
				var obj = trabajoService.query();
				obj.$promise.then(
					function(response) {
						response.forEach(function(element,index,array) {
							element.fec = funcionesService.timeVerbal(element.fec);
							element.fec_in = funcionesService.fecha(element.fec_in);
							element.fec_lim = funcionesService.fecha(element.fec_lim);
						});
						$scope.data = response;
						console.log($scope.data);
					},
					function(response) {
						console.log(response);
					}
				);
			};
			
			$scope.save = function(newObj) {
				newObj.fec_in = funcionesService.convertCadFecha(newObj.fec_in);
				newObj.fec_lim = funcionesService.convertCadFecha(newObj.fec_lim);
				var obj = new trabajoService(newObj);
				obj.$save(function(response) {
					var newData = {
						id: response.id,
						photo: response.photo,
						name_empresa: response.name_empresa,
						name: newObj.name,
						detail : newObj.detail,
						salary : newObj.salary,
						fec_in : funcionesService.fecha(newObj.fec_in),
						fec_lim : funcionesService.fecha(newObj.fec_lim),
						fec: funcionesService.timeVerbal(response.fec)
					};
					if( response.error == 'success' ) {
						$scope.mensaje = 'Registro insertado correctamente';
						$scope.data.push(newData);
					} else {
						$scope.mensaje = response.error;
					}
					console.log($scope.data);
				},function(response) {
					console.log(response);
				});
			};

			$scope.cancel = function() {
				$scope.newObj = {};
			};
			$scope.delete = function(id) {
				//console.log('eliminar ID: '+id);
				var remove = confirm('¿Está seguro de eliminar el registro?');
				if( remove ) {
					var obj = new trabajoService({id:id});
					obj.$remove(function(response) {
						console.log(response);
						for(var d in $scope.data) {
							if( $scope.data[d].id === id ) {
								$scope.data.splice(d,1);
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