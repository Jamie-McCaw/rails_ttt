class AddPlayerToTictactoe < ActiveRecord::Migration
  def change
    add_column :tictactoes, :player, :string
  end
end
