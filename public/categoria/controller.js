(function(angular) {

	'use strict';
	angular.module('categoriaModule').controller('categoriaCtrl',['$scope','categoriaService',
		function($scope,categoriaService) {
			$scope.find = function() {
				console.log('categoriaCtrl');
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