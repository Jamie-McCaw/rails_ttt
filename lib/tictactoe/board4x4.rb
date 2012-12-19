class Board4x4 < Board

  def initialize(cells = [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15])
    super(cells)
  end

  def dup
  	Board4x4.new(@cells.dup)
  end


  def winning_moves
    [
    [ @cells[0], @cells[1], @cells[2], @cells[3] ],
    [ @cells[4], @cells[5], @cells[6], @cells[7] ],
    [ @cells[8], @cells[9], @cells[10], @cells[11] ],
    [ @cells[12], @cells[13], @cells[14], @cells[15] ],

    [ @cells[0], @cells[4], @cells[8], @cells[12] ],
    [ @cells[1], @cells[5], @cells[9], @cells[13] ],
    [ @cells[2], @cells[6], @cells[10], @cells[14] ],
    [ @cells[3], @cells[7], @cells[11], @cells[15] ],

    [ @cells[0], @cells[5], @cells[10], @cells[15] ],
    [ @cells[3], @cells[6], @cells[9], @cells[12] ],
    ]
  end

  def board_design
    board = <<-BOARD
 #{@cells[0]} | #{@cells[1]} | #{@cells[2]} | #{@cells[3]}
---+---+---+---
 #{@cells[4]} | #{@cells[5]} | #{@cells[6]} | #{@cells[7]}
---+---+---+---
 #{@cells[8]} | #{@cells[9]} | #{@cells[10]}| #{@cells[11]}
---+---+---+---
 #{@cells[12]}| #{@cells[13]}| #{@cells[14]}| #{@cells[15]}
BOARD

  end
end
