class Board
  attr_accessor :cells

  def initialize(cells)
  	@cells = cells
  end

  def is_3x3?
    self.cells.count == 9
  end

  def is_4x4?
    self.cells.count == 16
  end

  def available_moves
    @cells.inject(0) do |sum, cell|
      sum += (cell.is_a?(Numeric) ? 1 : 0 )
    end
  end

  def available_spaces
    available_spaces = @cells.each_with_index.select { |i, idx| i.is_a?(Numeric) }
    available_spaces = available_spaces.map{|i| i[1] }
  end

  def move_available?(cell)
    @cells[cell].is_a?(Numeric)
  end

  def move(cell, type)
    if move_available?(cell)
      @cells[cell] = type
    end
  end

  def game_over?
    return true if winner
    return true if available_moves < 1
    false
  end

  def tie?
    return true if !winner && available_moves < 1
  end

  def winner
    return 'X' if player_wins?('X')
    return 'O' if player_wins?('O')
    return nil
  end

  def player_wins?(type)
    moves = winning_moves
    moves.each do |move_set|
      if move_set.all? { |cell| cell == type}
        return true
      end
    end
    return false
  end

end
