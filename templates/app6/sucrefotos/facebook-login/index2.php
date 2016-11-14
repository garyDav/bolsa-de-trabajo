<?php session_start(); ?>
<style>
  @font-face {
    font-family: 'icomoon';
    src:  url('../fonts/social/icomoon.eot?a7htlz');
    src:  url('../fonts/social/icomoon.eot?a7htlz#iefix') format('embedded-opentype'),
      url('../fonts/social/icomoon.ttf?a7htlz') format('truetype'),
      url('../fonts/social/icomoon.woff?a7htlz') format('woff'),
      url('../fonts/social/icomoon.svg?a7htlz#icomoon') format('svg');
    font-weight: normal;
    font-style: normal;
  }

  [class^="icon-"], [class*=" icon-"] {
    /* use !important to prevent issues with browser extensions that change fonts */
    font-family: 'icomoon' !important;
    speak: none;
    font-style: normal;
    font-weight: normal;
    font-variant: normal;
    text-transform: none;
    line-height: 1;

    /* Better Font Rendering =========== */
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
  }
  .icon-fb{
    font-size: 25px;
      padding-right: 15px;
  }
  .icon-fb:before {
    content: "\e900";
  }
  .text-fb{
    border-left: 1px solid #fff;
      padding-left: 15px;
      position: relative;
      top: -5px;
  }

  .login-button {
    -moz-box-shadow: inset 0px 1px 0px 0px #7a8eb9;
      -webkit-box-shadow: inset 0px 1px 0px 0px #7a8eb9;
      box-shadow: inset 0px 1px 0px 0px #7a8eb9;
      background: -webkit-gradient(linear, left top, left bottom, color-stop(0.05, #637aad), color-stop(1, #5972a7));
      background: -moz-linear-gradient(top, #637aad 5%, #5972a7 100%);
      background: -webkit-linear-gradient(top, #637aad 5%, #5972a7 100%);
      background: -o-linear-gradient(top, #637aad 5%, #5972a7 100%);
      background: -ms-linear-gradient(top, #637aad 5%, #5972a7 100%);
      background: linear-gradient(to bottom, #637aad 5%, #5972a7 100%);
      filter: progid:DXImageTransform.Microsoft.gradient(startColorstr='#637aad', endColorstr='#5972a7',GradientType=0);
      background-color: #637aad;
      border: 1px solid #314179;
      display: inline-block;
      cursor: pointer;
      color: #ffffff;
      font-family: Arial;
      font-size: 14px;
      font-weight: 600;
      width: 100%;
      padding: 10px 0;
      height: initial;
      text-decoration: none;
      text-align: center;
  }
  .login-button:hover {
    background:-webkit-gradient(linear, left top, left bottom, color-stop(0.05, #5972a7), color-stop(1, #637aad));
    background:-moz-linear-gradient(top, #5972a7 5%, #637aad 100%);
    background:-webkit-linear-gradient(top, #5972a7 5%, #637aad 100%);
    background:-o-linear-gradient(top, #5972a7 5%, #637aad 100%);
    background:-ms-linear-gradient(top, #5972a7 5%, #637aad 100%);
    background:linear-gradient(to bottom, #5972a7 5%, #637aad 100%);
    filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#5972a7', endColorstr='#637aad',GradientType=0);
    background-color:#5972a7;
  }
  .login-button:active {
    position:relative;
    top:1px;
  }
  #modal{
    width: 100%;
    height: 100%;
    position:absolute;
  }
</style>
<?php
//FACEBOOK SDKV5
require_once __DIR__ . '/facebook-php-sdk-v5/autoload.php';
//NEW FACEBOOK PON TU ID Y APP
$fb = new Facebook\Facebook([
  'app_id' => '1194364943969498',
  'app_secret' => 'bd005836971fe0d9b9ccb975c8ac8c68',
  'default_graph_version' => 'v2.2',
  ]);


$helper = $fb->getRedirectLoginHelper();
$permissions = ['email']; // optional
$loginUrl = $helper->getLoginUrl('http://sucrejs.com/facebook-login/login.php', $permissions);
?>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
        <!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">

<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js"></script>
    </head>
    <body>
    
      <?php
        if ($_SESSION['FBID']): 
      ?>

      <?php
      $_SESSION["facebookid"]=$user['id'];
      echo "Tu email es: ".$_SESSION["FBEMAIL"]."<br>"; 
      echo "Tu nombre es: ".$_SESSION["FBNAME"]."<br>"; 
      echo "Tu género es: ".$_SESSION["FBGENDER"]."<br>"; 
      echo '<img src="//graph.facebook.com/'.$_SESSION["FBID"].'/picture"><br>';
      echo '<img src="//graph.facebook.com/'.$_SESSION["FBID"].'/picture?type=large">';
      echo '<a href="logout.php"> Cerrar Sesion </a>';
      ?>

      <?php else: ?>
        <?php   echo "<a class='login-button' onclick=\"activar('".$loginUrl."')\"> <span class='icon-fb'></span>
    <span class='text-fb'>Iniciar con facebook</span></a>";
        ?>
      <?php endif ?>


    </body>

    <script>
        var ventana;

        function activar(url){
          var posicion_x; 
          var posicion_y; 
          posicion_x=(screen.width/2)-(690/2); 
          posicion_y=(screen.height/2)-(500/2);
            ventana = window.open(url,"mywindow","menubar=1,scrollbars=no,resizable=1,width=690,height=500,left="+posicion_x+",top="+posicion_y+"");
        }
        function recibir(id,name,email){
          console.log("Id: ",id);
          console.log("Name: ",name);
          console.log("Email: ",email);
          ventana.close();
        }
    </script>
 
</html>
