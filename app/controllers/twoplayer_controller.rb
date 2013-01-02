require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/inputoutput'
require 'tictactoe/board3x3'
require 'tictactoe/ai'

class TwoplayerController < ApplicationController
	def home
		tttgame = Tictactoe.new
		tttgame.game = Game.new.board.cells 
		tttgame.player = 'X'
		tttgame.save
		set_session_ids(tttgame)
		set_view_variables(tttgame)
	end

	def second_player
		tttgame = Tictactoe.find(params['id'])
		tttgame.player = 'O'
		tttgame.save
		set_session_ids(tttgame)
		set_view_variables(tttgame)
		render :template => 'twoplayer/home'
	end

	def move
		game, tttgame, player = move_setup
		if not_playable?(game)
			invalid_choice(game)
		else
			if player == tttgame.player
				make_the_move(tttgame, game, player)
			else
				invalid_choice(game)
			end
		end
	end

	def not_playable?(game)
		game.board.game_over? || !game.board.move_available?(params['cell'].to_i)
	end

	def move_setup
		game = Game.new
		tttgame = Tictactoe.find(session[:game_id])
		player = session[:player_id]
		game.board.cells = tttgame.game
		return game, tttgame, player
	end

	def invalid_choice(game)
		@move = 'invalid'
		check_game_state(game)
	end

	def check_game_state(game)
		if @move == 'invalid'
			invalid_move(game)
		elsif game.board.winner
			game_over(game)
		elsif game.board.tie?
			stalemate(game)
		else
			make_move(game)
		end
	end

	def make_the_move(tttgame, game, player)
		place_move_on_board(game, player)
		switch_player(tttgame)
		save_game(tttgame, game)
	end

	def save_game(tttgame, game)
		tttgame.game = game.board.cells
		tttgame.save
	end

	def place_move_on_board(game, player)
		game.board.move(params["cell"].to_i, player)
		check_game_state(game)
	end

	def switch_player(tttgame)
		tttgame.player = tttgame.player == 'X' ? 'O' : 'X'
	end

	def board
		game = Game.new
		tttgame = Tictactoe.find(session[:game_id])
		game.board.cells = tttgame.game
		turn = tttgame.player
		if game.board.winner
			board_type = game.board.winner
		elsif game.board.tie?
			board_type = 'Tie'
		else
			board_type = 'Continue the Game'
		end
		render :json => { :board => tttgame.game, :players_turn => turn, :state => board_type }
	end

	def game_over(game)
		render :json => { :game_over => "Player #{game.board.winner} Wins!", :player => params[:cell], :type => session[:player_id] }
	end

	def stalemate(game)
		render :json => { :stalemate => 'Tie Game.', :player => params[:cell], :type => session[:player_id] }
	end

	def make_move(game)
		render :json => { :player => params[:cell], :type => session[:player_id] }
	end

	def invalid_move(game)
		render :json => {:invalid => "Invalid Move"}
	end

	def set_view_variables(tttgame)
		@cells = tttgame.game
		@host = request.host_with_port
		@protocol = request.protocol
	end

	def set_session_ids(tttgame)
		@game_id = tttgame.id		
		player_id = tttgame.player
		session[:player_id] = player_id
		session[:game_id] = @game_id
	end
end
