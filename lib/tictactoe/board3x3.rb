class Board3x3 < Board

  def initialize(cells = [0,1,2,3,4,5,6,7,8])
    super(cells)
  end

  def dup
  	Board3x3.new(@cells.dup)
  end


  def winning_moves
    [
    [ @cells[0], @cells[1], @cells[2] ],
    [ @cells[3], @cells[4], @cells[5] ],
    [ @cells[6], @cells[7], @cells[8] ],

    [ @cells[0], @cells[3], @cells[6] ],
    [ @cells[1], @cells[4], @cells[7] ],
    [ @cells[2], @cells[5], @cells[8] ],

    [ @cells[0], @cells[4], @cells[8] ],
    [ @cells[6], @cells[4], @cells[2] ]
    ]
  end

  def board_design
    board = <<-BOARD
 #{@cells[0]} | #{@cells[1]} | #{@cells[2]}
---+---+---
 #{@cells[3]} | #{@cells[4]} | #{@cells[5]}
---+---+---
 #{@cells[6]} | #{@cells[7]} | #{@cells[8]}
BOARD
  end
end

