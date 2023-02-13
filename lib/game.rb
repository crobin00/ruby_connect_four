# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'

# Handles game logic
class Game
  attr_reader :board
  attr_accessor :player_one, :player_two, :current_turn

  def initialize
    @board = Board.new
  end

  def run
    player_setup
    puts 'Enter a column 1-7 or q to quit.'
    loop do
      puts "#{current_turn.name}'s turn:"
      input = player_input
      break if input == 'q' || input == 'Q'
      next unless place_piece(input)
      puts board.display
      switch_turn
    end
  end

  def player_setup
    puts 'Enter player 1 name: '
    name = gets.chomp
    @player_one = Player.new(name, 1)
    puts 'Enter player 2 name: '
    name = gets.chomp
    @player_two = Player.new(name, 2)
    @current_turn = player_one
  end

  def switch_turn
    self.current_turn = current_turn == player_one ? player_two : player_one
  end

  def place_piece(input)
    col_input = input.to_i - 1

    unless board.col_full?(col_input)
      board.place_piece(current_turn.piece, col_input)
      return true
    end

    puts 'Column full. Please input another'
    false
  end

  def player_input
    loop do
      input = gets.chomp
      return input if check_input(input)

      puts 'Input error!'
    end
  end

  def check_input(input)
    return true if (input.to_i >= 1 && input.to_i <= 7) ||
                   input == 'q' || input == 'Q'

    false
  end
end
