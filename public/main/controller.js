(function(angular){
	'use strict';
	angular.module('mainModule').controller('mainCtrl',['$scope','loginService','$rootScope','categoriaService','$location','sessionService',
		function($scope,loginService,$rootScope,categoriaService,$location,sessionService) {
			$scope.mensaje = '';
			$scope.msgtxt = '';
			$scope.nav = function() {
				console.log('Hola navegacion');
			};
			$scope.navCate = function(id) {
				$location.path('categoria/'+id);
			};
			$scope.navAdminCategoria = function() {
				$location.path('crear/categoria');
			};
			$scope.navAdminEmpresa = function() {
				$location.path('crear/empresa');
			};
			$scope.navAdminTrabajo = function() {
				$location.path('crear/trabajo');
			};

			$scope.find = function() {
				var obj = categoriaService.query();
				obj.$promise.then(function(response){
					$scope.data = response;
					console.log($scope.data);
				},function(response){
					console.log(response);
				});
				if( sessionService.get('user') == 'admin' ) {
					$rootScope.user_id = sessionService.get('userId');
					console.log(sessionService.get('userId'));
					$rootScope.c_admin = true;
				}
				else {
					$rootScope.c_admin = false;
				}
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