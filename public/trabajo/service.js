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

	angular.module('trabajoModule').factory('trabajoEmpresaService',['$http',
		function($http) {
			return {
				getTrabajo: function(id) {
					return $http.get('rest/v1/trabajo/empresa/'+id);
				}
			};
		}
	]);

})(window.angular);
