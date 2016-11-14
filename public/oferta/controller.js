(function(angular) {

	'use strict';
	angular.module('ofertaModule').controller('ofertaCtrl',['$scope','categoriaService',
		function($scope,categoriaService) {
			$scope.find_cate = function() {
				var categorias = categoriaService.query();
				categorias.$promise.then(
					function(response) {
						$scope.categoria = response;
						console.log($scope.categoria);
					},
					function(response) {}
				);
			};
		}
	]);


})(window.angular);