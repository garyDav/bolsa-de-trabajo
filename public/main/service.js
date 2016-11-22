(function(angular) {

	'use strict';
	angular.module('mainModule').factory('usuarioService',['$resource',
		function($resource) {
			return $resource('rest/v1/empleador/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);
	angular.module('mainModule').factory('categoriaService',['$resource',
		function($resource) {
			return $resource('rest/v1/categoria/:id', {
				id: '@id'
			}, {
				update: {
					method: 'PUT'
				}
			});
		}
	]);

	angular.module('mainModule').factory('loginService',function ($http,$location,sessionService,$rootScope) {
		return {
			login: function(user,scope) {
				var $promise = $http.post('rest/v1/login',user);
				$promise.then(function(res){
					var uid = res.data.error;
					if(uid == 'success') {
						//scope.msgtxt = 'Correct Information';
						sessionService.set('user',res.data.id);
						$rootScope.c_user = true;
						$location.path('/admin');
					} else {
						scope.msgtxt = 'Error Information';
						$location.path('/ingresar');
					}
				});
			},
			lougout: function() {
				sessionService.destroy('user');
				$location.path('/ingresar');
			}
		};
	});

	angular.module('mainModule').factory('sessionService',function ($http) {
		return {
			set: function(key,value) {
				console.log(key);
				console.log(value);
				return localStorage.setItem(key,value);
			},
			get: function(key) {
				return localStorage.getItem(key);
			},
			destroy: function(key) {
				return localStorage.removeItem(key);
			}
		};
	});


})(window.angular);
