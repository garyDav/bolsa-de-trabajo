(function(angular) {

	'use strict';
	angular.module('empresaModule').factory('empresaService',['$resource',
		function($resource) {
			return $resource('rest/v1/empresa/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);


})(window.angular);
