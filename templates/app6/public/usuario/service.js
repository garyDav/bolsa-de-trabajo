(function(angular){
	'use strict';

	angular.module('usuarioModule').factory('usuarioService',['$resource',
		function($resource){
			return $resource('rest/v1/usuarios/:id',{
				id: '@id'
			}, {
				update:{
					method:'PUT'
				}
			});
		}
	]);


})(window.angular);