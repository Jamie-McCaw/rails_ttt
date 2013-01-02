class Tictactoe < ActiveRecord::Base
  attr_accessible :game
  serialize :game

  X_PLAYER = 'X'
  O_PLAYER = 'O'


  def self.create_x_game
    tttgame = Tictactoe.new
    tttgame.game = Game.new.board.cells 
    tttgame.player = X_PLAYER
    tttgame.save!
    tttgame
  end

  def self.create_y_game_for(id)
    tttgame = Tictactoe.find(id)
    tttgame.player = O_PLAYER
    tttgame.save!
    tttgame
  end

  def self.play_move_for(game_id, player, cell)
    tttgame = Tictactoe.find(game_id)
    tttgame.move(player, cell)
  end

  def move(moved_player, cell)
    if not_playable?(cell)
      invalid_choice
    else
      if moved_player == player
        make_the_move(moved_player, cell)
      else
        invalid_choice
      end
    end
  end

  def board
    game = Game.new
    game.board.cells = self.game
    return game
  end

  def get_game_state
    if board.board.winner
      return board.board.winner
    elsif board.board.tie?
      return 'Tie'
    else
      return 'Continue the Game'
    end
  end

  def not_playable?(cell)
    board.board.game_over? || !board.board.move_available?(cell)
  end

  def invalid_choice
    @move = 'invalid'
    check_game_state
  end

  def check_game_state
    if @move == 'invalid'
      return board, 'invalid'
    elsif board.board.winner
      return board, 'winner'
    elsif board.board.tie?
      return board, 'tie'
    else
      return board, 'playon'
    end
  end

  def make_the_move(player, cell)
    place_move_on_board(board, player, cell)
    switch_player
    save_game
  end

  def save_game
    self.game = board.board.cells
    self.save
  end

  def place_move_on_board(game, player, cell)
    board.board.move(cell, player)
    check_game_state
  end

  def switch_player
    current_player = self.player
    self.player = (current_player == X_PLAYER ? O_PLAYER : X_PLAYER)
  end

end
