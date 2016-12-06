(function(angular) {

	'use strict';
	angular.module('publicarModule').factory('publicarService',['$resource',
		function($resource) {
			return $resource('rest/v1/publicar/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

})(window.angular);