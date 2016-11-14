(function(angular){

	angular.module('sucreModule').controller('signinCtrl', ['$scope','$http', function($scope,$http){
		// code
	}]);
	angular.module('sucreModule').controller('signupCtrl', ['$scope','$http', function($scope,$http){
		$scope.user = {
			name:"",
			username:"",
			email:"",
			password:"",
		}
		$scope.post = function(){
			var r = $scope.verificar();
			if(r.isvalid){
				console.log($scope.user);
			}
			else{
				__notification(r.msg);
			}

		}
		$scope.verificar = function(){
			var response = {isvalid:true,msg:[]}

			if(!__isFill($scope.user.name)){
				__invalid('name');
				response.isvalid = false;
				response.msg.push("El campo NOMBRE es incorrecto");
			}
			if(!__isFillWithNumber($scope.user.username)){
				__invalid('username');
				response.isvalid = false;
				response.msg.push("El campo NOMBRE DE USUARIO es incorrecto");
			}
			if(!__isEmail($scope.user.email)){
				__invalid('email');
				response.isvalid = false;
				response.msg.push("El campo CORREO es incorrecto");
			}
			if(!__isFillWithNumber($scope.user.password)){
				__invalid('password');
				response.isvalid = false;
				response.msg.push("El campo PASSWORD es incorrecto");
			}
			return response;
		}
	}])
})(window.angular);