//Uso del modo strict de JavaScript
'use strict';

//Variable global mainApplicationModuleName donde carga el modulo principal
var mainApplicationModuleName = 'bolsaT';
var mainApplicationModule = angular.module(mainApplicationModuleName, ['ngResource','ngRoute','ui.sortable','mainModule','categoriaModule','departamentoModule','empresaModule','sucursalModule','trabajoModule','userModule','publicarModule','LocalStorageModule','angular-loading-bar','ngAnimate']);

mainApplicationModule.config(['$locationProvider',function($locationProvider) {
	$locationProvider.html5Mode(true);
}]);

mainApplicationModule.config(['localStorageServiceProvider',function(localStorageServiceProvider){
	localStorageServiceProvider.setPrefix('bolsaT');
}]);

mainApplicationModule.config(['cfpLoadingBarProvider', function(cfpLoadingBarProvider) {
    cfpLoadingBarProvider.includeSpinner = true;
}]);

mainApplicationModule.run(function($rootScope,$location,sessionService,loginService) {
	var routespermission = ['/','/categoria','/categoria/:id','/departamento','/departamento/:id','/empresa','/empresa/:id','/usuario/:id','/ingresar','/registrate','/sucursal','/sucursal/:id','/trabajo','/trabajos/empresa/:id','/usuario','/usuario/:id','/crear/publicacion','/publicar'];
	$rootScope.$on('$routeChangeStart',function() {
		//console.log( 'Entra navegacion: '+routespermission.indexOf($location.path()) );
		//console.log( 'Entra navegacion: '+ routespermission.indexOf($location.path()) );
		//if( routespermission.indexOf($location.path()) != -1 && loginService.isLogged() ) {
		if( loginService.isLogged() ) {
			if( sessionService.get('user') == 'admin' )
				$rootScope.c_admin = true;
			else
				$rootScope.c_admin = false;
			/*if( sessionService.get('user') == 'user' )
				$rootScope.c_user = true;*/
		}
	});
});


angular.element(document).ready(function() {
	angular.bootstrap(document, [mainApplicationModuleName]);
});
