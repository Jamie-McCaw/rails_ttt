class CreateTwoplayers < ActiveRecord::Migration
  def change
    create_table :twoplayers do |t|

      t.timestamps
    end
  end
end
