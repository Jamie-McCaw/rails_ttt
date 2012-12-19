class Tictactoe < ActiveRecord::Base
  attr_accessible :game
  serialize :game
end
