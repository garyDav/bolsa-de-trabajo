(function(angular) {

	'use strict';
	angular.module('categoriaModule').factory('categoriaService',['$resource',
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

	angular.module('categoriaModule').factory('trabajoCategoriaService',['$http',
		function($http) {
			return {
				getTrabajoCate: function(id) {
					return $http.get('rest/v1/trabajo/categoria/'+id);
				}
			};
		}
	]);

})(window.angular);
