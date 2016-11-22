(function(angular){
	'use strict';

	angular.module('empresaModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/empresa',{
					templateUrl: 'public/empresa/views/list-empresa.view.html'
				}).when('/empresa/:id',{
					templateUrl: 'public/empresa/views/view-empresa.view.html'
				});
		}
	]);

})(window.angular);