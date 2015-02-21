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
    "ABCDEF12"  => mktime(0, 0, 0, 7, 1, 2000),
    "AAAAAAAA" => mktime(0, 0, 0, 7, 1, 2016),
    "BBBBBBBB" => mktime(0, 0, 0, 7, 1, 2011)
);
$now = time();
$date = $validKeys[$token];

echo $diff;
if($date != null &&  $date > $now)
{
echo "100";
}
else
{
echo "-1\n";
}
echo "<br>now=$now\n<br>";
echo "tokenDate=$date\n<br>";
echo "token=$token\n<br>";
echo "user=$usr\n<br>";
?>
 