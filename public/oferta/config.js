(function(angular){
	'use strict';

	angular.module('ofertaModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/oferta',{
					templateUrl: 'public/oferta/views/list-oferta.view.html'
				}).when('/oferta/categoria/:id',{
					templateUrl: 'public/oferta/views/view-oferta.view.html'
				});
		}
	]);

})(window.angular);