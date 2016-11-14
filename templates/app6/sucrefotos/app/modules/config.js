(function(angular){
	'use strict';

	/*ccaModule*/
	angular.module('sucreModule').config(['$locationProvider',
		function($localtionProvider){
			$localtionProvider.html5Mode(true);
		}
	]);
	angular.module('sucreModule').config(['$routeProvider', function($routeProvider){
			$routeProvider.when('/signin',{
				templateUrl:'views/sign-in.html'
			}).when('/signup',{
				templateUrl:'views/sign-up.html'
			}).when('/feeds',{
				templateUrl:'views/fotos.html'
			}).otherwise('/');
	}]);
})(window.angular);