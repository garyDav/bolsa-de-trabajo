//Uso del modo strict de JavaScript
'use strict';

//Variable global mainApplicationModuleName donde carga el modulo principal
var mainApplicationModuleName = 'bolsaT';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngResource','ngRoute','ui.sortable','mainModule','LocalStorageModule','angular-loading-bar','ngAnimate']);

mainApplicationModule.config(['$locationProvider',function($locationProvider) {
	$locationProvider.html5Mode(true);
}]);

mainApplicationModule.config(['localStorageServiceProvider',function(localStorageServiceProvider){
	localStorageServiceProvider.setPrefix('bolsaT');
}]);

mainApplicationModule.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = true;
}]);


angular.element(document).ready(function() {
	angular.bootstrap(document, [mainApplicationModuleName]);
});
