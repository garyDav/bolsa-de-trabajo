$( document ).ready(function(){
	//barra de navegacion
	 $(".button-collapse").sideNav();
	//carousel de imagenes y contenidos 
	 //$('.carousel.carousel-slider').carousel({full_width: true});
	 // $('.carousel').carousel(full_width: true);
	  //$('.carousel').carousel({full_width: true});
	  //funcion para iniciar el parallax
	   $('.parallax').parallax();

      	//scroll a secccion
      	 $('.scrollspy').scrollSpy({scrollOffset:1});
      	 //zoom a imagenes
       $('.materialboxed').materialbox();
       //ventana Modal
       $('.modal-trigger').leanModal(  
       			{
      dismissible: true, // Modal can be dismissed by clicking outside of the modal
      opacity: .5, // Opacity of modal background
      in_duration: 300, // Transition in duration
      out_duration: 200, // Transition out duration
      starting_top: '4%', // Starting top style attribute
      ending_top: '4%', // Ending top style attribute
   //   ready: function() { alert('Ready'); }, // Callback for Modal open
    //  complete: function() { alert('Closed'); } // Callback for Modal close
    }
       	);

       $('select').material_select();
   

});


/*Funciones Generales */

/* verifica si esta lleno solo A-Za-z omite los números*/
function __isFill(word){
  if(word === "") return false;
  else return RegExp(/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]*$/).test(word);
}
/* verifica si esta lleno solo 0-9A-Za-z*/
function __isFillWithNumber(word){
  if(word === "") return false;
  else return RegExp(/^[0-9A-Za-zÁÉÍÓÚáéíóúÑñ@\s]*$/).test(word);
}
/* verifica si es email correcto */
function __isEmail(word){
  if(word === "") return false;
  else return RegExp(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,4})+$/).test(word);
}
function __invalid(element){
  var e = document.querySelector("#"+element);
  e.className = 'invalid '+ e.className;
}
function __notification(msg){
  var el = [];
  if(typeof(msg) == "string"){
    el.push(msg);
  }
  else{
    el = msg;
  }
  el.forEach(function(i){
    Materialize.toast(i, 4000);
  })

}