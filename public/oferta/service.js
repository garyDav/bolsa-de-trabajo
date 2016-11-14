(function(angular) {

	'use strict';
	angular.module('ofertaModule').factory('categoriaService',['$resource',
		function($resource) {
			return $resource('rest/v1/categoria/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);


})(window.angular);
