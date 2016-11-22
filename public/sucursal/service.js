(function(angular) {

	'use strict';
	angular.module('sucursalModule').factory('sucursalService',['$resource',
		function($resource) {
			return $resource('rest/v1/sucursal/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);


})(window.angular);
