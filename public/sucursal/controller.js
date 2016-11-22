(function(angular) {

	'use strict';
	angular.module('sucursalModule').controller('sucursalCtrl',['$scope','sucursalService',
		function($scope,sucursalService) {
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