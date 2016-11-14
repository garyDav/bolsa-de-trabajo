(function(angular){
	'use strict';

	angular.module('mainModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/',{
					templateUrl: 'public/main/views/nav-bar.view.html'
				}).
				when('/admin',{
					resolve: {
						"check":function($location,sessionService) {
							if(!sessionService.get('user'))
								$location.path('/signin');
						}
					},
					templateUrl: 'public/main/views/main.view.html'
				}).
				when('/signin',{
					templateUrl: 'public/main/views/signin.view.html'
				}).
				when('/signup',{
					templateUrl: 'public/main/views/signup.view.html'
				}).
				otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);