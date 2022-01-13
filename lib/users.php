<?php
function handle_user($method,$b,$input) {
	if($method=='GET') {
		show_user();
	} else 
    if($method=='PUT') {
        set_user($b,$input);
        
    }
}

function set_user($b,$input) {
// print_r($input);
// if(!isset($input['username1']) || $input['username2']=='') {
//     header("HTTP/1.1 400 Bad Request");
//     print json_encode(['errormesg'=>"No username given."]);
//     exit;
// }
$b=1;
$username=$input['username1'];
global $mysqli;
$sql = 'update players set username=?, token=md5(CONCAT( ?, NOW()))  where player=?';
$st2 = $mysqli->prepare($sql);
$st2->bind_param('sss',$username,$username,$b);
$st2->execute();
$username=$input['username2'];
$b=2;
$sql = 'update players set username=?, token=md5(CONCAT( ?, NOW()))  where player=?';
$st2 = $mysqli->prepare($sql);
$st2->bind_param('sss',$username,$username,$b);
$st2->execute();



update_game_status();
$sql = 'select * from players where player=?';
$st = $mysqli->prepare($sql);
$st->bind_param('s',$b);
$st->execute();
$res = $st->get_result();
header('Content-type: application/json');
print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);


}


function current_color($token) {
	
	global $mysqli;
	if($token==null) {return(null);}
	$sql = 'select * from players where token=?';
	$st = $mysqli->prepare($sql);
	$st->bind_param('s',$token);
	$st->execute();
	$res = $st->get_result();
	if($row=$res->fetch_assoc()) {
		return($row['player']);
	}
	return(null);
}






?>
