class Twoplayer < ActiveRecord::Base
  attr_accessible :game
  serialize :game
end
