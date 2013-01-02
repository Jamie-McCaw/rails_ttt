function make_move_multiplayer(cell){ 
	$.ajaxSetup({async:false});

	$.get('/twoplayer/move/' + cell.id, function(data) {
		if (data['invalid'] != undefined) {
			alert('Invalid Move');
		} else if (data['comp'] == 'invalid') {
			alert('Invalid Move');

		}	else if (data['game_over'] != undefined) {
			document.getElementById('label').innerHTML = data['game_over'];
			document.getElementById(cell.id).innerHTML = '<br />' + data['type'];
			setInterval();
			//poll();
		}	else if (data['stalemate'] != undefined) {
			document.getElementById('label').innerHTML = data['stalemate'];
			document.getElementById(cell.id).innerHTML = '<br />' + data['type'];
			setInterval();
			//poll();
		} else {
			document.getElementById(cell.id).innerHTML = '<br />' + data['type'];
			setInterval();
			//poll();
		}
	});
}

setInterval(function(){
	$.ajax({ url: '/board', success: function(data){
		for(i=0;i<(data['board'].length);i++){
			document.getElementById(i).innerHTML = '<br />' + data['board'][i];
			if (data['state'] == 'Tie') { 
				document.getElementById('label').innerHTML = 'Tie Game';
			} else if (data['state'] == 'X' || data['state'] == 'O') {
				document.getElementById('label').innerHTML = 'Player ' + data['state'] + ' Wins';
			} else {
				document.getElementById('label').innerHTML = 'Player ' + data['players_turn'] + "'s Turn";
			}
		}
	}, dataType: "json"});
}, 1000);
