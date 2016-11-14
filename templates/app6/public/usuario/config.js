(function(angular){
	'use strict';

	angular.module('usuarioModule').config(['$routeProvider',
		function($routeProvider){
			$routeProvider.when('/signin',{
				templateUrl:'public/usuario/views/signin.view.html'
			}).when('/signup',{
				templateUrl:'public/usuario/views/signup.view.html'
			}).when('/publicaciones',{
				templateUrl:'public/usuario/views/publicaciones.view.html'
			}).otherwise('/');
		}
	]);

})(window.angular);