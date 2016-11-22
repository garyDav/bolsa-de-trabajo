(function(angular) {

	'use strict';
	angular.module('departamentoModule').controller('departamentoCtrl',['$scope','departamentoService',
		function($scope,departamentoService) {
			$scope.find = function() {
				/*var categorias = categoriaService.query();
				categorias.$promise.then(
					function(response) {
						$scope.categoria = response;
						console.log($scope.categoria);
					},
					function(response) {}
				);*/
			};
		}
	]);


})(window.angular);