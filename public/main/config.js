(function(angular){
	'use strict';

	angular.module('mainModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/',{
					templateUrl: 'public/main/views/index.view.html'
				}).
				when('/usuario/:id',{
					resolve: {
						"check":function($location,sessionService) {
							if( sessionService.get('user') != 'admin' )
								$location.path('/ingresar');
						}
					},
					templateUrl: 'public/main/views/view-user.view.html'
				}).
				when('/ingresar',{
					templateUrl: 'public/main/views/signin.view.html'
				}).
				when('/registrar',{
					templateUrl: 'public/main/views/signup.view.html'
				}).otherwise({
					redirectTo: '/'
				});
		}
	]);

})(window.angular);