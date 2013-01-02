require 'spec_helper'
describe 'Two Player' do
	subject { page }

	describe 'Home Page' do
	 	before { visit root_path }

	  it { should have_selector('title', text: 'TicTacToe') }
	  it { should have_selector('h4', text: 'Click any square to start.') }
	  it { should have_button('New Game') }
	  it { should_not have_selector('p') }  
	end

	describe 'Two Player Page' do
		before { visit twoplayer_path }

	  it { should have_selector('title', text: 'TicTacToe') }
	  it { should have_selector('h4', text: 'Click any square to start.') }
	  it { should have_button('New Game') }
	  it { should have_selector('p') }
	end 
end