(function(angular) {

	'use strict';
	angular.module('departamentoModule').factory('departamentoService',['$resource',
		function($resource) {
			return $resource('rest/v1/departamento/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);


})(window.angular);
