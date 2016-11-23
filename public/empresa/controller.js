(function(angular) {

	'use strict';
	angular.module('empresaModule').controller('empresaCtrl',['$scope','empresaService','$routeParams',
		function($scope,empresaService,$routeParams) {
			$scope.find = function() {
				var empresa = empresaService.query();
				empresa.$promise.then(
					function(response) {
						$scope.data = response;
						console.log($scope.data);
					},
					function(response) {}
				);
			};
			$scope.findOne = function() {
				var obj = empresaService.get({id: $routeParams.id});
				obj.$promise.then(
					function(response) {
						$scope.one_data = response;
						console.log($scope.one_data);
					}
				);
			};
		}
	]);


})(window.angular);