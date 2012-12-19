class CreateTictactoes < ActiveRecord::Migration
  def change
    create_table :tictactoes do |t|

    	t.string :game

      t.timestamps
    end
  end
end
