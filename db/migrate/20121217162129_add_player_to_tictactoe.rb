class AddPlayerToTictactoe < ActiveRecord::Migration
  def change
    alter_table :tictactoes do |t|

    	t.string :player

      t.timestamps
    end
  end
end
