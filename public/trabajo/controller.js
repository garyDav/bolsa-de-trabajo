(function(angular) {

	'use strict';
	angular.module('trabajoModule').controller('trabajoCtrl',['$scope','trabajoService',
		function($scope,trabajoService) {
			$scope.find = function() {
				/*var trabajo = trabajoService.query();
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