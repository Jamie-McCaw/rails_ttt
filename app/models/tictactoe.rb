class Tictactoe < ActiveRecord::Base
  attr_accessible :game
  serialize :game

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

  def self.play_move_for(game_id, player_id, cell)
    game = Game.new
    tttgame = Tictactoe.find(game_id)
    player = player_id
    game.board.cells = tttgame.game

    if not_playable?(game, cell)
      invalid_choice(game)
    else
      if player == tttgame.player
        make_the_move(tttgame, game, player, cell)
      else
        invalid_choice(game)
      end
    end
  end

  def self.move_setup(game_id, player_id)
    game = Game.new
    tttgame = Tictactoe.find(game_id)
    player = player_id
    game.board.cells = tttgame.game
    return game, tttgame, player
  end

  def self.get_game_state(game)
    if game.board.winner
      return game.board.winner
    elsif game.board.tie?
      return 'Tie'
    else
      return 'Continue the Game'
    end
  end

  def self.not_playable?(game, cell)
    game.board.game_over? || !game.board.move_available?(cell)
  end

  def self.invalid_choice(game)
    @move = 'invalid'
    check_game_state(game)
  end

  def self.check_game_state(game)
    if @move == 'invalid'
      return game, 'invalid'
    elsif game.board.winner
      return game, 'winner'
    elsif game.board.tie?
      return game, 'tie'
    else
      return game, 'playon'
    end
  end

  def self.make_the_move(tttgame, game, player, cell)
    place_move_on_board(game, player, cell)
    switch_player(tttgame)
    save_game(tttgame, game)
  end

  def self.save_game(tttgame, game)
    tttgame.game = game.board.cells
    tttgame.save
  end

  def self.place_move_on_board(game, player, cell)
    game.board.move(cell, player)
    check_game_state(game)
  end

  def self.switch_player(tttgame)
    tttgame.player = tttgame.player == X_PLAYER ? O_PLAYER : X_PLAYER
  end

end
