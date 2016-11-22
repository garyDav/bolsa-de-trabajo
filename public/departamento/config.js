(function(angular){
	'use strict';

	angular.module('departamentoModule').config(['$routeProvider',
		function($routeProvider) {
			$routeProvider.
				when('/departamento',{
					templateUrl: 'public/departamento/views/list-departamento.view.html'
				}).when('/departamento/:id',{
					templateUrl: 'public/departamento/views/view-departamento.view.html'
				});
		}
	]);

})(window.angular);