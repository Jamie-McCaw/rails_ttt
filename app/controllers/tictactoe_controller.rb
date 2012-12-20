require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/inputoutput'
require 'tictactoe/board3x3'
require 'tictactoe/ai'

class TictactoeController < ApplicationController
	def home
		tttgame = Tictactoe.new
		tttgame.game = Game.new.board.cells 
		tttgame.player = 'X'
		tttgame.save
		player = tttgame.player
		game_id = tttgame.id
		session[:game_id] = game_id
		session[:player] = player
	end

	def move
		game = Game.new
		tttgame = Tictactoe.find(session[:game_id])
		game.board.cells = tttgame.game
		if game.board.game_over? || !game.board.move_available?(params['cell'].to_i)
			@move = 'invalid'
			check_game_state(game)
		else
			game.board.move(params["cell"].to_i, 'X')
			if !game.board.game_over?
				@move = game.ai.make_move(game.board)
				game.board.move(@move, 'O')
			end
			check_game_state(game)
			tttgame.game = game.board.cells
			tttgame.save
		end
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
		render :json => { :game_over => "Player #{game.board.winner} Wins!", :player => params[:cell], :comp => @move }
	end

	def stalemate(game)
		render :json => { :stalemate => 'Tie Game.', :player => params[:cell], :comp => @move }
	end

	def make_move(game)
		render :json => { :player => params[:cell], :comp => @move }
	end

	def invalid_move(game)
		render :json => {:invalid => "Invalid Move"}
	end
end