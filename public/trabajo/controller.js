(function(angular) {

	'use strict';
	angular.module('trabajoModule').controller('trabajoCtrl',['$scope','trabajoService','trabajoEmpresaService','$routeParams','funcionesService',
		function($scope,trabajoService,trabajoEmpresaService,$routeParams,funcionesService) {
			$scope.find = function() {
				$scope.data = [];
				var f = new Date();
				var ahora = f.getFullYear() + "-" + (f.getMonth() +1) + "-" + f.getDate();
				var obj = trabajoEmpresaService.getTrabajo($routeParams.id);
				//console.log(obj);
				obj.then(
					function(response) {
						console.log(response.data);
						var cont = 0;
						response.data.forEach(function(element,index,array) {
							console.log('Entraaaa');
							if( funcionesService.fechaLimMayor(element.fec_lim, ahora) ) {
								//response.data.splice(index,1);
								element.fec = funcionesService.timeVerbal(element.fec);
								element.fec_in = funcionesService.fecha(element.fec_in);
								element.fec_lim = funcionesService.fecha(element.fec_lim);
								$scope.data.push(element);
								console.log('no tiene que estar aqui');
							}
						});
						//$scope.data = response.data;
						console.log($scope.data);
					},function(response) {
						console.log(response);
					}
				);
			};
		}
	]);


})(window.angular);