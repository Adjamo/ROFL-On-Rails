<html>
<head>
<title>Delete</title>
</head>

<?php

  // Return user to the same page they came from
  $file_n = $_POST[filename];
  $array = array("<body onload=\"window.location='", $file_n, "'\">");
  $redirect = join("", $array);
  echo $redirect;

  //Get the username and password for MySQL
  $myFile = "/usr/bin/MySQL config.txt";
  $fh = fopen($myFile, 'r');
  $mysql_username = fgets($fh);
  $mysql_password = fgets($fh);
  fclose($fh);

  $mysql_username = trim(substr($mysql_username, 9, strlen($mysql_username)));
  $mysql_password = trim(substr($mysql_password, 9, strlen($mysql_password)));

  //Try to make a connection to MySQL
  $dbhost = 'localhost';
  $dbuser = $mysql_username;
  $dbpass = $mysql_password;

  $conn = mysql_connect($dbhost,$dbuser,$dbpass) or die ('Failed to connect to MySQL<br />');

  //Print error message if connection attempt failed
  if(!$conn)
   {
     echo "Connection to database failed";
     die('Error: ' . mysql_error());
   }

  //Connect to this users database
  $dbname = "LOL";
  mysql_select_db($dbname, $conn);

  $table_var = $_POST[table];
  $iddata_var = $_POST[iddata];
  $id = substr($iddata_var, 0, strpos($iddata_var, "\t"));

  $query_ = "delete from $table_var where id = \"$id\";";

  //MySQL Query
  $result = mysql_query($query_) ;

  echo "<form action='./Pals_index.htmlol' method='post'>";
  echo "Records updated<br />";
  echo "<input type='Submit' value='Return' />";
  echo "</form><br /><br />";

?>

</body>
</html>
