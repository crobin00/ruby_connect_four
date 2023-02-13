# frozen_string_literal: true

require_relative 'display'
require_relative 'board'
require_relative 'player'

# Handles game logic
class Game
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def run
    place_piece
    puts board.display
  end

  def player_setup
    puts 'Enter player 1 name: '
    name = gets.chomp
    @player_one = Player.new(name, 1)
    puts 'Enter player 2 name: '
    name = gets.chomp
    @player_two = Player.new(name, 2)
  end

  def place_piece
    puts 'Enter a column number'
    loop do
      input = player_input.to_i - 1

      unless board.col_full?(input)
        board.place_piece(1, input)
        return
      end

      puts 'Column full. Please input another'
    end
  end

  def player_input
    loop do
      input = gets.chomp
      return input if check_input(input)

      puts 'Input error!'
    end
  end

  def check_input(input)
    input_int = input.to_i
    return true if input_int >= 1 && input_int <= 7

    false
  end
end
