class AddPlayerToTictactoe < ActiveRecord::Migration
  def change
    add_column :tictactoes do |t|

    	t.string :player

      t.timestamps
    end
  end
end
