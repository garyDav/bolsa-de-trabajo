(function(angular){
	'use strict';

	angular.module('userModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/usuario',{
					templateUrl: 'public/user/views/list-user.view.html'
				}).when('/usuario/:id',{
					templateUrl: 'public/user/views/view-user.view.html'
				});
		}
	]);

})(window.angular);