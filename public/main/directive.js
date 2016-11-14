(function(angular){

	'use strict';
	angular.module('mainModule').directive('navDirective',function(){
		return {
			templateUrl: 'public/main/views/nav-bar.view.html'
		};
	}).directive('footerDirective',function(){
		return {
			templateUrl: 'public/main/views/footer.view.html'
		};
	}).directive('mainDirective',function(){
		return {
			templateUrl: 'public/main/views/main.view.html'
		};
	});


})(window.angular);