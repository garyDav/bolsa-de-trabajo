<?php 
session_start();
session_unset();
    $_SESSION['FBID'] = NULL;
    $_SESSION['FBNAME'] = NULL;
    $_SESSION['FBEMAIL'] =  NULL;
    $_SESSION['FBGENDER'] =  NULL;
header("Location: index.php");        // you can enter home page here ( Eg : header("Location: " ."http://www.krizna.com"); 
?>
