(function(angular) {

	'use strict';
	angular.module('userModule').factory('userService',['$resource',
		function($resource) {
			return $resource('rest/v1/user/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);


})(window.angular);
