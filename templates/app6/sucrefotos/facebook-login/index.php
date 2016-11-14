<?php     
session_start();

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
      echo '<br><a href="logout.php"> Cerrar Sesion </a>';
      ?>

      <?php else: ?>
        <?php   echo '<a class=" btn btn-primary" href="'.$loginUrl.'">'; ?><i class="fa fa-facebook"></i> Login con Facebook</a>
      <?php endif ?>

    </body>
 
</html>
