(function(angular) {

	'use strict';
	angular.module('trabajoModule').factory('trabajoService',['$resource',
		function($resource) {
			return $resource('rest/v1/trabajo/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);


})(window.angular);
