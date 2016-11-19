(function(angular){
	'use strict';

	angular.module('mainModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/',{
					templateUrl: 'public/main/views/index.view.html'
				}).
				when('/admin',{
					resolve: {
						"check":function($location,sessionService) {
							if(!sessionService.get('user'))
								$location.path('/ingresar');
						}
					},
					templateUrl: 'public/main/views/main.view.html'
				}).
				when('/ingresar',{
					templateUrl: 'public/main/views/signin.view.html'
				}).
				when('/registrate',{
					templateUrl: 'public/main/views/signup.view.html'
				}).
				otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);