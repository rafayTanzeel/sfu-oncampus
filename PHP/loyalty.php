<?php
//e.g. http://www.burningthumb.com/API/SFU/loyalty.php?useget=1&user=awiebe04&token=AAAAAAAA
error_reporting(E_ALL);
$usr = $_POST["user"];
$token = $_POST["token"];

if(1 == $_GET["useget"])
{
$usr = $_GET["user"];
$token = $_GET["token"];
}

$validKeys = array(
    "ABCDEF12"  => array(mktime(0, 0, 0, 7, 1, 2000),100),
    "AAAAAAAA" => array(mktime(0, 0, 0, 7, 1, 2016),500),
    "CCCCCCCC" => array(mktime(0, 0, 0, 7, 1, 2016),200),
    "BBBBBBBB" => array(mktime(0, 0, 0, 7, 1, 2011),100)
);
$now = time();
$date = $validKeys[$token][0];

if($date != null &&  $date > $now)
{
$val = $validKeys[$token][1];
echo "$val \n";
}
else
{
echo "-1 \n";
}
echo "<br>now=$now\n<br>";
echo "tokenDate=$date\n<br>";
echo "token=$token\n<br>";
echo "user=$usr\n<br>";
echo "<head><title>APITest</title></head>";
?>
 