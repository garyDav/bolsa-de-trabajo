(function(angular){
	'use strict';
	angular.module('usuarioModule').controller('usuarioCtrl',['$scope','usuarioService',
		function($scope,usuarioService){
			$scope.mensaje = '';
			$scope.create = function() {
				var usuario = new usuarioService({
					name : this.name,
					user : this.user,
					email : this.email,
					password : this.password
				});
				usuario.$save(function(response) {
					if(response.error == 'success') {
						console.log(response.id);
					} else {
						$scope.mensaje = response.error;
						console.log($scope.mensaje);
					}
				},function(error) {
					console.log(error);
				});
			};
		}
	]);


})(window.angular);