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
    let box=`<div id="pieces_board">
    <h3 id="select">select piece</h3>
   <img src="images/pieces/BCLH.jpg" class="pieces">
   <img src="images/pieces/BCLS.jpg" class="pieces">
   <img src="images/pieces/BCTH.jpg" class="pieces">
   <img src="images/pieces/BCTS.jpg" class="pieces">
   <img src="images/pieces/BSLH.jpg" class="pieces">
   <img src="images/pieces/BSLS.jpg" class="pieces">
   <img src="images/pieces/BSTH.jpg" class="pieces">
   <img src="images/pieces/BSTS.jpg" class="pieces">
   <img src="images/pieces/WCLH.jpg" class="pieces">
   <img src="images/pieces/WCLS.jpg" class="pieces">
   <img src="images/pieces/WCTH.jpg" class="pieces">
   <img src="images/pieces/WCTS.jpg" class="pieces">
   <img src="images/pieces/WSLH.jpg" class="pieces">
   <img src="images/pieces/WSLS.jpg" class="pieces">
   <img src="images/pieces/WSTH.jpg" class="pieces">
   <img src="images/pieces/WSTS.jpg" class="pieces">
   
    
  </div>`;
    $('#cart').html(s);
    $('#box').html(box);
    draw_empty_board();
    fill_board();
}



function draw_empty_board(){
    let t='<table id="quarto_table">';
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
	$.ajax({url: "http://localhost/MyProject/quarto.php/board", method: 'get',success: fill_board_by_data });
}

function fill_board_by_data(data) {
	board=data;
	for(var i=0;i<data.length;i++) {
		var o = data[i];
		var id = '#square_'+ o.x +'_' + o.y;
		var c = (o.piece!=null)?o.piece_color + o.piece:'';
		var pc= (o.piece!=null)?'piece'+o.piece_color:'';
		var im = (o.piece!=null)?'<img class="piece" src="images/pieces/'+c+'.jpg">':'';
        // var im = (o.piece!=null)?c:'';
		$(id).addClass(o.b_color+'_square').html(im);
	}
 
	}
