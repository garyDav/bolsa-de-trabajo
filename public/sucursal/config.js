(function(angular){
	'use strict';

	angular.module('sucursalModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/sucursal',{
					templateUrl: 'public/sucursal/views/list-sucursal.view.html'
				}).when('/sucursal/:id',{
					templateUrl: 'public/sucursal/views/view-sucursal.view.html'
				});
		}
	]);

})(window.angular);