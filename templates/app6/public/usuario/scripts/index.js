$( document ).ready(function(){
	//barra de navegacion
	 $(".button-collapse").sideNav();
	//carousel de imagenes y contenidos 
	 //$('.carousel.carousel-slider').carousel({full_width: true});
	 // $('.carousel').carousel(full_width: true);
	  //$('.carousel').carousel({full_width: true});
	  //funcion para iniciar el parallax
	   $('.parallax').parallax();
	   //funcion para iniciar el slider de imagenes con un ancho total
      
      $('.slider').slider({
          full_width: true,
      });

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

