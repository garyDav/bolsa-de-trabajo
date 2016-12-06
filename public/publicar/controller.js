(function(angular) {

	'use strict';
	angular.module('publicarModule').controller('publicarCtrl',['$scope','funcionesService','publicarService','departamentoService',
		function($scope,funcionesService,publicarService,departamentoService) {
			$scope.data = [];
			$scope.find = function() {
				var obj = publicarService.query();
				obj.$promise.then(
					function(response) {
						response.forEach(function(element,index,array) {
							element.fec = funcionesService.timeVerbal(element.fec);
						});
						$scope.data = response;
						console.log($scope.data);
					},
					function(response) {
						console.log(response);
					}
				);
			};
			$scope.findDepartamento = function() {
				var obj = departamentoService.query();
				obj.$promise.then(
					function(response) {
						$scope.dataDepartamento = response;
						console.log($scope.data);
					},
					function(response) {
						console.log(response);
					}
				);
			};
			$scope.save = function(newObj) {
				var obj = new publicarService(newObj);
				obj.$save(function(response) {
					/*var newData = {
						id: response.id,
						departamento: response.depa,
						work: newObj.work,
						name: newObj.name,
						age: newObj.age,
						email : newObj.email,
						cell : newObj.cell,
						detail : newObj.detail,
						fec: funcionesService.timeVerbal(response.fec)
					};*/
					if( response.error == 'success' ) {
						$scope.mensaje = 'Registro insertado correctamente';
						//$scope.data.push(newData);
					} else {
						$scope.mensaje = response.error;
					}
					$scope.newObj = {};
					console.log($scope.data);
				},function(response) {
					console.log(response);
				});
			};

			$scope.cancel = function() {
				$scope.newObj = {};
			};
		}
	]);


})(window.angular);
