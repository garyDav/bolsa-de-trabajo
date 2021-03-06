(function(angular){
	'use strict';

	angular.module('trabajoModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/trabajo',{
					templateUrl: 'public/trabajo/views/list-trabajo.view.html'
				}).when('/trabajos/empresa/:id',{
					templateUrl: 'public/trabajo/views/view-trabajo.view.html'
				}).when('/crear/trabajo',{
					templateUrl: 'public/trabajo/views/create-trabajo.view.html'
				});
		}
	]);

})(window.angular);