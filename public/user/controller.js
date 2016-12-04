(function(angular) {

	'use strict';
	angular.module('userModule').controller('userCtrl',['$scope','userService','$routeParams','funcionesService','$rootScope',
		function($scope,userService,$routeParams,funcionesService,$rootScope) {
			$scope.one_data = {};

			$scope.findOne = function() {
				var obj = userService.get({id: $routeParams.id});
				obj.$promise.then(
					function(response) {
						response.fec = funcionesService.timeVerbal(response.fec);
						$scope.one_data = response;
						$rootScope.user_id = response.id;
						console.log($scope.one_data);
					}
				);
			};
			$scope.create = function() {
				var usuario = new userService({
					name : this.name,
					last_name : this.last_name,
					email: this.email,
					password : this.password,
					cell : this.cell
				});
				usuario.$save(function(response) {
					console.log(response);
					if(response.error == 'success') {
						$scope.mensaje = 'Usuario registrado correctamente.';
					} else
						$scope.mensaje = response.error;
				},function(error) {
					console.log(error);
				});
				$scope.name = '';
				$scope.last_name = '';
				$scope.cell = '';
				$scope.email = '';
				$scope.password = '';
			};

		}
	]);


})(window.angular);