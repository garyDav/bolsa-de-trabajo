(function(angular){
	'use strict';
	angular.module('mainModule').controller('mainCtrl',['$scope','usuarioService','loginService','$rootScope',
		function($scope,usuarioService,loginService,$rootScope) {
			$scope.mensaje = '';
			$scope.msgtxt = '';
			$scope.create = function() {
				var usuario = new usuarioService({
					foto: '',
					nombre : this.nombre,
					apellido : this.apellido,
					empresa: this.empresa,
					correo : this.correo,
					contra : this.contra,
					telefono: '',
					celular: ''
				});
				usuario.$save(function(response) {
					console.log(response);
					console.log(response.error);
					$scope.mensaje = response.error;
				},function(error) {
					console.log(error);
				});
			};
			$scope.ingresar = function(user) {
				loginService.login(user,$scope);
				//$rootScope.isLogget = true;
			};
			$scope.lougout = function() {
				console.log('entra logout');
				loginService.lougout();
				//$rootScope.isLogget = false;
			};
		}
	]);

})(window.angular);