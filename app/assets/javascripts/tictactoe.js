function make_move(cell){ 
	$.ajaxSetup({async:false});

	$.get('/move/' + cell.id, function(data) {
		if (data['invalid'] != undefined) {
			alert('Invalid Move');
		} else if (data['comp'] == 'invalid') {
			alert('Invalid Move');

		}	else if (data['game_over'] != undefined) {
			document.getElementById('label').innerHTML = data['game_over'];
			document.getElementById(cell.id).innerHTML = '<br />' + 'X';
			document.getElementById(data['comp']).innerHTML = '<br />' + 'O';
		}	else if (data['stalemate'] != undefined) {
			document.getElementById('label').innerHTML = data['stalemate'];
			document.getElementById(cell.id).innerHTML = '<br />' + 'X';
			document.getElementById(data['comp']).innerHTML = '<br />' + 'O';
		} else {
			document.getElementById(cell.id).innerHTML = '<br />' + 'X';
			document.getElementById(data['comp']).innerHTML = '<br />' + 'O';
		}
	});
}
