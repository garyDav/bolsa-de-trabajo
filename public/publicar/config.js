(function(angular){
	'use strict';

	angular.module('publicarModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/crear/publicacion',{
					templateUrl: 'public/publicar/views/create-publicar.view.html'
				}).when('/publicar',{
					templateUrl: 'public/publicar/views/list-publicar.view.html'
				});
		}
	]);

})(window.angular);
