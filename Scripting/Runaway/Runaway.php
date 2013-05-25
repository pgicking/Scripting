<html>
<head>
<title>Runaway</title>
<meta http-equiv="refresh" content="15" >
</head>
<body>
 
<?php
//the beginnings of the ssh runaway page
 
$file = "boxen.txt";

$f = fopen($file, "r");
if($f == NULL){
    print "File: \"$file\" not found <br />";
}

else {
while ($line = fgets($f,1000) ) {
    print $line . "<br />";
  }
}
print "are you working?";

//fclose($file); 

?>
</body>
</html> 
