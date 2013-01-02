require 'tictactoe/game'
require 'tictactoe/board'
require 'tictactoe/inputoutput'
require 'tictactoe/board3x3'
require 'tictactoe/ai'

class TwoplayerController < ApplicationController
	def home
          tttgame = Tictactoe.create_x_game
          render_game(tttgame)
	end

	def second_player
          tttgame = Tictactoe.create_y_game_for(params['id'])
          render_game(tttgame)
	end

        def render_game(tttgame)
          set_session_ids(tttgame)
          set_view_variables(tttgame)
          render :home
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

	def move
          game, result = Tictactoe.play_move_for(session[:game_id], session[:player_id], params[:cell].to_i)

          case result
          when 'invalid'
            invalid_move(game)
          when 'winner'
            game_over(game)
          when 'tie'
            stalemate(game)
          else
            make_move(game)
          end
	end

	def board
          tttgame = Tictactoe.find(session[:game_id])
          turn = tttgame.player
          game_state_data = tttgame.get_game_state
          render :json => { :board => tttgame.game, :players_turn => turn, :state => game_state_data }
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
