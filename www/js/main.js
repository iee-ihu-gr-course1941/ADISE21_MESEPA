var me={token:null,piece_color:null};



$(function () {
	start();
});

function start(){
let st;
st=` <div class="input-group">
<div class="input-group-prepend">
  <span class="input-group-text" id="">Name of a&b player</span>
</div>
<input type="text" class="form-control">
<input type="text" class="form-control">
</div>
<button  onclick="btn()" class="btn" >
START
</button>`
$('#cart').html(st);
}
function btn(){
    let s="";
    $('#cart').html(s);
    draw_empty_board();
    fill_board();
}



function draw_empty_board(){
    let t='<table id="quarto_table">';
    for (let i=1; i<5; i++){
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
	$.ajax({url: "http://localhost/MyProject/quarto.php/board", method: 'get',success: fill_board_by_data });
}

function fill_board_by_data(data) {
	board=data;
	for(var i=0;i<data.length;i++) {
		var o = data[i];
		var id = '#square_'+ o.x +'_' + o.y;
		var c = (o.piece!=null)?o.piece_color + o.piece:'';
		var pc= (o.piece!=null)?'piece'+o.piece_color:'';
		// var im = (o.piece!=null)?'<img class="piece '+pc+'" src="images/'+c+'.png">':'';
        var im = (o.piece!=null)?c:'';
		$(id).addClass(o.b_color+'_square').html(im);
	}
 
	}
