class Game

  attr_accessor :board, :ai

  def initialize(io = InputOutput.new)
    @io = io
    @type = 'O'
    @ai = AI.new('O')
    @board = Board3x3.new
  end

  def menu
    clear_screen
    print_welcome_message
    game_size_menu
    print_input_symbol
    get_menu_input
  end

  def game_size_menu
    @io.outputs "Enter 1 for 3x3, or 2 for 4x4:"
  end

  def print_welcome_message
    @io.outputs 'Welcome to Tic Tac Toe!'
  end

  def print_player_x_turn
    @io.outputs "It is X's turn"
  end

  def print_input_symbol
    @io.prints "-> "
  end

  def get_menu_input
    choice = @io.input.to_i
    if choice == 1
      @board = Board3x3.new
    elsif choice == 2
      @board = Board4x4.new
    else
      menu
    end
  end

  def game_loop
    menu
    until @board.game_over?
      draw_board
      @board.move(get_move, 'X')
      end_turn
    end
  end

  def get_move
    validate_user_input(@io.input)
  end

  def validate_user_input(user_input)
    if user_input =~ /[0-9]/ && @board.move_available?(user_input.to_i)
      return user_input.to_i.abs
    else
      invalid_move
    end
  end

  def invalid_move
    invalid_choice
    print_input_symbol
    get_move
  end

  def invalid_choice
    @io.outputs "Invalid Choice"
  end

  def clear_screen
    system('clear')
  end

  def end_turn
    draw_board
    computer_turn
    draw_board
    check_game_state
  end

  def check_game_state
    if @board.game_over?
      print_winning_message
    end
  end

  def print_winning_message
    if @board.winner
      @io.outputs(@board.winner + " Wins")
    else
      @io.outputs "Tie Game"
    end
  end

  def draw_board
    clear_screen
    print_welcome_message
    print_board
    print_player_x_turn
    print_input_symbol
  end

  def print_board
    @io.outputs @board.board_design
  end

  def computer_turn
    @io.outputs "Thinking..."
    move = @ai.make_move(@board)
    @board.move(move, @type)
  end
end
