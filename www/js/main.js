var me={token:null,player:null};
var game_status={};
var board={};
var last_update=new Date().getTime();
var timer=null;
var position;
var sPiece="";

$(function () {
    // $('#btn').click(draw_empty_board);
	start();
    game_status_update();
});

function start(){
let st;
st=` <div class="input-group">
<div class="input-group-prepend">
  <span class="input-group-text" id="">Name of  player</span>
</div>
<input type="text" class="form-control" id="username1">
</div>
<button  class="btn" onclick="btn()" >
START
</button>
<label for="player">Choose a player:</label>

<select name="player" id="player">
  <option value="1">Player 1</option>
  <option value="2">Player2</option>

</select>
`
$('#cart').html(st);
}

function selectPiece(event) {
    if (sPiece!="") {
        return sPiece;}
    else{
        if (event.target.tagName == "IMG") {
            //console.log(event.target.id);
            let text = event.target.id;
            const myArray = text.split("_");
            // console.log(`${myArray[0]}${myArray[1]}`);
            sPiece = myArray;
            console.log(sPiece);
            event.target.classList.add("picked");

        }
    }
}

function selectPlacement(){
    if (event.target.tagName=="TD") {
        // console.log(event.target.id);
        let squarePosition = event.target.id;
        const positionArray = squarePosition.split("_");
        position=positionArray;
        console.log(position);

    }
    do_move();
}

function btn(){
    if($('#username1').val()=='') {
        alert('You have to set a username');
        return;
    
    }else{
    login_to_game();
    let s="";
    let box=`<div onclick="selectPiece(event)" id="pieces_board">
    <h3 class="select">select piece</h3>
   <img src="images/pieces/BCLH.jpg" class="pieces" id="B_CLH">
   <img src="images/pieces/BCLS.jpg" class="pieces" id="B_CLS">
   <img src="images/pieces/BCTH.jpg" class="pieces" id="B_CTH">
   <img src="images/pieces/BCTS.jpg" class="pieces" id="B_CTS">
   <img src="images/pieces/BSLH.jpg" class="pieces" id="B_SLH">
   <img src="images/pieces/BSLS.jpg" class="pieces" id="B_SLS">
   <img src="images/pieces/BSTH.jpg" class="pieces" id="B_STH">
   <img src="images/pieces/BSTS.jpg" class="pieces" id="B_STS">
   <img src="images/pieces/WCLH.jpg" class="pieces" id="W_CLH">
   <img src="images/pieces/WCLS.jpg" class="pieces" id="W_CLS">
   <img src="images/pieces/WCTH.jpg" class="pieces" id="W_CTH">
   <img src="images/pieces/WCTS.jpg" class="pieces" id="W_CTS">
   <img src="images/pieces/WSLH.jpg" class="pieces" id="W_SLH">
   <img src="images/pieces/WSLS.jpg" class="pieces" id="W_SLS">
   <img src="images/pieces/WSTH.jpg" class="pieces" id="W_STH">
   <img src="images/pieces/WSTS.jpg" class="pieces" id="W_STS">
   
   
    
  </div>`;
    $('#cart').html(s);
    $('#box').html(box);
    draw_empty_board();
    fill_board();
    }
}



function draw_empty_board(){
    let t='<table onclick="selectPlacement(event)" id="quarto_table">';
    for (let i=4; i>0; i--){
        t +='<tr>';
        for(let j=1; j<5; j++){
            t+='<td class="quarto_square" id="square_'+j+'_'+i+'">' + j +','+i+'</td>'; 
        }
        t +='</tr>';
    }
    t+='</table>';
$('#quarto_board').html(t);

}

function fill_board() {
	$.ajax({url: "https://users.iee.ihu.gr/~it185251/ADISE21_MESEPA/www/quarto.php/board",
    headers: {"X-Token": me.token},
     method: 'get',
     success: fill_board_by_data });
}

function fill_board_by_data(data) {
	board=data;
	for(var i=0;i<data.length;i++) {
		var o = data[i];
		var id = '#square_'+ o.x +'_' + o.y;
		var c = (o.piece!=null)?o.piece_color + o.piece:'';
        
		var pc= (o.piece!=null)?'piece'+o.piece_color:'';
		var im = (o.piece!=null)?'<img class="piece" src="images/pieces/'+c+'.jpg">':`${o.x},${o.y}`;
        // var im = (o.piece!=null)?c:'';
    
		$(id).addClass(o.b_color+'_square').html(im);
	}
 
	}


    function login_to_game() {
        if($('#username1').val()=='') {
            alert('You have to set a username');
                return;
            
        }
       

        
        var player =$('#player').val();
         // draw_empty_board();
        fill_board();
        
        $.ajax({url: "https://users.iee.ihu.gr/~it185251/ADISE21_MESEPA/www/quarto.php/players/"+player,

                method: 'PUT',
                dataType: "json",
                headers: {"X-Token": me.token},
                contentType: 'application/json',
                data: JSON.stringify( {username1: $('#username1').val(), player: player}),
                success: login_result,
                error: login_error
        });

        }

        function login_result(data) {
            console.log("paok");
            me = data[0];
            // // $('#game_initializer').hide();
            // // update_info();
            // game_status_update();
        }



        function login_error(data,y,z,c) {
            var x = data.responseJSON;
            console.log(data.response);
            alert(x.errormesg);
        }


        function game_status_update() {
	
            clearTimeout(timer);
            $.ajax({url: "https://users.iee.ihu.gr/~it185251/ADISE21_MESEPA/www/quarto.php/status",
            headers: {"X-Token": me.token},
            success: update_status });
        }
        
        function update_status(data) {
            last_update=new Date().getTime();
            var game_stat_old = game_status;
            game_status=data[0];
            // update_info();
            clearTimeout(timer);
            if(game_status.p_turn==me.player &&  me.player!=null) {
                x=0;
                // do play
                if(game_stat_old.p_turn!=game_status.p_turn) {
                    fill_board();
                }
                // $('#move_div').show(1000);
                timer=setTimeout(function() { game_status_update();}, 15000);
            } else {
                // must wait for something
                // $('#move_div').hide(1000);
                timer=setTimeout(function() { game_status_update();}, 4000);
            }
             
        }
        
        function update_info(){
            $('#game_info').html("I am Player: "+me.piece_color+", my name is "+me.username +'<br>Token='+me.token+'<br>Game state: '+game_status.status+', '+ game_status.p_turn+' must play now.');
            
            
        }


        function do_move() {
            console.log("dsfsd")
            var a =position;
            var b =sPiece;
            console.log(b,position);
            
          
            $.ajax({url: "https://users.iee.ihu.gr/~it185251/ADISE21_MESEPA/www/quarto.php/board/piece",
                    method: 'PUT',
                    dataType: "json",
                    contentType: 'application/json',
                    data: JSON.stringify( {x: a[1], y: a[2], color: b[0], piece: b[1]}),
                    headers: {"X-Token": me.token},
                    success: move_result,
                    error: login_error});
            sPiece="";

        }
        function move_result(data){
            game_status_update();
            fill_board_by_data(data);
        }