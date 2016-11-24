(function(angular) {

	'use strict';
	angular.module('empresaModule').controller('empresaCtrl',['$scope','empresaService','$routeParams','categoriaService','upload2',
		function($scope,empresaService,$routeParams,categoriaService,upload2) {
			$scope.find = function() {
				var empresa = empresaService.query();
				empresa.$promise.then(
					function(response) {
						$scope.data = response;
						console.log($scope.data);
					},
					function(response) {}
				);
			};
			$scope.findOne = function() {
				var obj = empresaService.get({id: $routeParams.id});
				obj.$promise.then(
					function(response) {
						$scope.one_data = response;
						console.log($scope.one_data);
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
				var img = '';
				var msg = '';
				upload2.saveImg($scope.file).then(function(response) {
					if(response) {
						img = response.src;
						msg = response.msg;
						newObj.photo = img;

						var obj = new empresaService(newObj);
						obj.$save(function(response) {
							var newData = {
								id: response.id,
								id_categoria: newObj.id_categoria,
								nameCate: response.nameCate,
								name : newObj.name,
								email : newObj.email,
								address : newObj.address,
								phone : newObj.phone,
								cell : newObj.cell,
								photo: newObj.photo,
								detail: newObj.detail
							};
							console.log(response);
							if( response.error == 'success' ) {
								$scope.mensaje = 'Registro insertado correctamente e '+msg;
								$scope.data.push(newData);
							} else {
								$scope.mensaje = response.error;
							}
							console.log($scope.data);
						},function(response) {
							console.log(response);
						});
						console.log(newObj);
					}
				});
				
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