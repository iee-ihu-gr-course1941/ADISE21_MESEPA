<?php
function handle_user($method,$b,$input) {
	if($method=='GET') {
		show_user();
        echo '<script>alert("Welcome to Geeks for Geeks")</script>';
	} else 
    if($method=='PUT') {
        set_user($b,$input);
        
        
    }
}

function set_user($b,$input) {
print_r($input);
if(!isset($input['username1']) || $input['username2']=='') {
    header("HTTP/1.1 400 Bad Request");
    print json_encode(['errormesg'=>"No username given."]);
    exit;
}
$username=$input['username1'];
global $mysqli;
// $sql = 'select count(*) as c from players where piece_color=? and username is not null';
// $st = $mysqli->prepare($sql);
// $st->bind_param('s',$b);
// $st->execute();
// $res = $st->get_result();
// $r = $res->fetch_all(MYSQLI_ASSOC);
// if($r[0]['c']>0) {
//     header("HTTP/1.1 400 Bad Request");
//     print json_encode(['errormesg'=>"Player $b is already set. Please select another color."]);
//     exit;
// }
$sql = 'update players set username=?, token=md5(CONCAT( ?, NOW()))  where piece_color=?';
$st2 = $mysqli->prepare($sql);
$st2->bind_param('sss',$username,$username,$b);
$st2->execute();


// update_game_status();
// $sql = 'select * from players where piece_color=?';
// $st = $mysqli->prepare($sql);
// $st->bind_param('s',$b);
// $st->execute();
// $res = $st->get_result();
// header('Content-type: application/json');
// print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT);


}






?>
