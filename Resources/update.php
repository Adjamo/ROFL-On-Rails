<html>
<head>
<title>Update</title>
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

  $colNames_var = $_POST[colNames];
  $table_var = $_POST[table];
  $id_var = $_POST[id];
  $datadata_var = $_POST[datadata];
  $id = substr($iddata_var, 0, strpos($iddata_var, "\t"));

  $values_array = explode("\t", $datadata_var);
  $colNames_array = explode("\t", $colNames_var);

  $l_size = $_POST[loop_size];

  for ($i = 0; $i < $l_size; $i++ )
  {
    $str1 = "data_$i";
    $y_data = $_POST[$str1];
    $str2 = "col_$i";
    $x_data = $_POST[$str2];

    $query_ = "update $table_var set $x_data = \"$y_data\" where id = \"$id_var\";";

    //MySQL Query
    $result = mysql_query($query_) ;

  }

  echo "<form action='./Pals_index.htmlol' method='post'>";
  echo "Records updated<br />";
  echo "<input type='Submit' value='Return' />";
  echo "</form><br /><br />";

  //Close connection
  mysql_close($conn);

?>

</body>
</html>
