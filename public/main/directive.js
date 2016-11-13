(function(angular){

	'use strict';
	angular.module('mainModule').directive('navDirective',function(){
		return {
			templateUrl: 'public/main/views/nav-bar.view.html'
		};
	});


})(window.angular);