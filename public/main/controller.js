(function(angular){
	'use strict';
	angular.module('mainModule').controller('mainCtrl',['$scope','usuarioService','loginService','$rootScope','categoriaService','$location',
		function($scope,usuarioService,loginService,$rootScope,categoriaService,$location) {
			$scope.mensaje = '';
			$scope.msgtxt = '';
			$scope.nav = function() {
				console.log('Hola navegacion');
			};
			$scope.navCate = function(id) {
				$location.path('categoria/'+id);
			};
			$scope.find = function() {
				var obj = categoriaService.query();
				obj.$promise.then(function(response){
					$scope.data = response;
					console.log($scope.data);
				},function(response){
					console.log(response);
				});
			};
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