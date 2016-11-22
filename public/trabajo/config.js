(function(angular){
	'use strict';

	angular.module('trabajoModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/trabajo',{
					templateUrl: 'public/trabajo/views/list-trabajo.view.html'
				}).when('/trabajo/:id',{
					templateUrl: 'public/trabajo/views/view-trabajo.view.html'
				});
		}
	]);

})(window.angular);