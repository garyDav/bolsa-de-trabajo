(function(angular){
	'use strict';

	angular.module('categoriaModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/categoria',{
					templateUrl: 'public/categoria/views/list-categoria.view.html'
				}).when('/categoria/:id',{
					templateUrl: 'public/categoria/views/view-categoria.view.html'
				});
		}
	]);

})(window.angular);