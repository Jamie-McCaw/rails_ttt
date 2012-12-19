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
		@game_id = tttgame.id
		player_id = tttgame.player
		session[:player_id] = player_id
		session[:game_id] = @game_id
		@cells = tttgame.game
		@host = request.host_with_port
		@protocol = request.protocol
	end

	def second_player
		tttgame = Tictactoe.find(params['id'])
		tttgame.player = 'O'
		tttgame.save
		@game_id = tttgame.id		
		player_id = tttgame.player
		session[:player_id] = player_id
		session[:game_id] = @game_id
		@cells = tttgame.game
		@host = request.host_with_port
		@protocol = request.protocol
		render :template => 'twoplayer/home'
	end

	def move
		game = Game.new
		tttgame = Tictactoe.find(session[:game_id])
		player = session[:player_id]
		game.board.cells = tttgame.game
		if game.board.game_over? || !game.board.move_available?(params['cell'].to_i)
			@move = 'invalid'
			check_game_state(game)
		else
			if player == tttgame.player
				game.board.move(params["cell"].to_i, player)
				check_game_state(game)
				tttgame.player = tttgame.player == 'X' ? 'O' : 'X'
				tttgame.game = game.board.cells
				tttgame.save
			else
				@move = 'invalid'
				check_game_state(game)
			end
		end
	end

	def board
		game = Tictactoe.find(session[:game_id])
		render :json => { :board => game.game}
	end

	def check_game_state(game)
		if game.board.winner
			game_over(game)
		elsif game.board.tie?
			stalemate(game)
		elsif @move == 'invalid'
			invalid_move(game)	
		else
			make_move(game)
		end
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
end
