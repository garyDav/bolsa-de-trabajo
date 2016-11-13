(function(angular){
	'use strict';

	angular.module('mainModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/',{
					templateUrl: 'public/main/views/main.view.html'
				}).
				otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);