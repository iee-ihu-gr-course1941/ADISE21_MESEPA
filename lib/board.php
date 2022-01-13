<?php 
function show_board(){
    

    global $mysqli;
    $sql = 'select * from board' ;
    $st = $mysqli->prepare($sql);
    $st-> execute();
    $res = $st->get_result();

    header ('content-type: application/json');
    print json_encode($res->fetch_all(MYSQLI_ASSOC), JSON_PRETTY_PRINT );
    
    

    
}

function reset_board() {
    global $mysqli;

    $sql='call clean_board()';
    $mysqli->query($sql);
    show_board() ;
}





function move_piece($x,$y,$color,$piece,$token) {
	
	if($token==null || $token=='') {
		header("HTTP/1.1 400 Bad Request");
		print json_encode(['errormesg'=>"token is not set."]);
		exit;
	}
	
	// $player = current_player($token);
	// if($player==null ) {
	// 	header("HTTP/1.1 400 Bad Request");
	// 	print json_encode(['errormesg'=>"You are not a player of this game."]);
	// 	exit;
	// }
	// $status = read_status();
	// if($status['status']!='started') {
	// 	header("HTTP/1.1 400 Bad Request");
	// 	print json_encode(['errormesg'=>"Game is not in action."]);
	// 	exit;
	// }
	// if($status['p_turn']!=$player) {
	// 	header("HTTP/1.1 400 Bad Request");
	// 	print json_encode(['errormesg'=>"It is not your turn."]);
	// 	exit;
	// }
	// // $orig_board=read_board();
	// $board=read_board();
	// $n = add_valid_moves_to_piece($x,$y);
	// if($n==false) {
	// 	header("HTTP/1.1 400 Bad Request");
	// 	print json_encode(['errormesg'=>"This piece cannot be placed."]);
	// 	exit;
	// }
    // else{
    do_move($x,$y,$color,$piece);
    //     exit;
    // }

	// header("HTTP/1.1 400 Bad Request");
	// print json_encode(['errormesg'=>"This move is illegal."]);
	// exit;
}
function do_move($x,$y,$color,$piece) {

	global $mysqli;
	$sql = 'call `place_piece`(?,?,?,?);';
	$st = $mysqli->prepare($sql);
	$st->bind_param('ssss',$x,$y,$piece,$color );
	$st->execute();

	header('Content-type: application/json');
	print json_encode(read_board(), JSON_PRETTY_PRINT);

}



function read_board() {
	global $mysqli;
	$sql = 'select * from board';
	$st = $mysqli->prepare($sql);
	$st->execute();
	$res = $st->get_result();
	return($res->fetch_all(MYSQLI_ASSOC));
}

function add_valid_moves_to_piece($x,$y){
$a=read_board();
if($a[0]['piece']==NULL){
    return true;
}
else{
    return false;
}



}


?>