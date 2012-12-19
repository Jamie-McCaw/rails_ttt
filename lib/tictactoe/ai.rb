class AI

  attr_accessor :type

  def initialize(type)
    @type = type
    @infinity = 10
    @best_move = nil
  end

  def second_move_of_4_x_4?(board)
    board.is_4x4? && board.available_moves == 15
  end

  def fourth_move_of_4_x_4?(board)
    board.is_4x4? && board.available_moves == 13
  end

  def make_move(board)
    if optimizable?(board)
      @best_move = optimized_move(board)
    else
      negamax(board, @type, 1, -@infinity, @infinity)
    end
    return @best_move
  end

  def optimized_move(board)
    return board.available_spaces.shuffle.first
  end

  def optimizable?(board)
    return second_move_of_4_x_4?(board) || fourth_move_of_4_x_4?(board)
  end

  def opponent(piece)
    piece == 'X' ? 'O' : 'X'
  end

  def winner(board, player)
    if board.winner == player
      return 1
    elsif board.winner == opponent(player)
      return -1
    else
      return 0
    end
  end

  def negamax(board, player, depth, alpha, beta)
    if board.game_over?
      return winner(board, player)
    else
      best_rank = -@infinity
      opponent = opponent(player)

      board.available_spaces.each do |move|
        current_board = board.dup
        current_board.move(move, player)
        rank = -negamax(current_board, opponent, depth - 1, -beta, -alpha)
        if rank > alpha
          alpha = rank
          @best_move = move if depth == 1
        end
        break if alpha >= beta
      end
      return alpha
    end
  end
end
